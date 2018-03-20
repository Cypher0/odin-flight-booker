require 'test_helper'

class FlightBookingTest < ActionDispatch::IntegrationTest

  def setup
    @flight    = flights(:test_flight)
    @passenger = passengers(:test_passenger)
    @other     = passengers(:other_passenger)
  end

  test "booking a flight" do
    get new_booking_path, params: { num_tickets: 2, selected_flight: @flight.id }
    assert_template 'bookings/new'
    assert_select 'td', @flight.id.to_s
    assert_select 'td', @flight.date.strftime("%d %b %Y %H:%M")
    assert_select 'td', @flight.from_airport.code
    assert_select 'td', @flight.to_airport.code
    assert_select 'label', count: 4
    post bookings_path(params: { flight_id: @flight.id, booking: {
                                 passengers_attributes: { "0" => { name: @passenger.name,  email: @passenger.email },
                                                          "1" => { name: @other.name, email: @other.email }}}})
    booking = assigns(:booking)
    assert_redirected_to booking_path(booking)
    follow_redirect!
    assert_select 'td', @flight.date.strftime("%d %b %Y %H:%M")
    assert_select 'td', @flight.from_airport.name
    assert_select 'td', @flight.to_airport.name
    booking.passengers.each do |passenger|
      assert_match passenger.name,  response.body
      assert_match passenger.email, response.body
    end
  end
end
