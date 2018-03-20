require 'test_helper'

class FlightsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @flight = flights(:test_flight)
  end

  test "index form elements" do
    get flights_path
    assert_template 'flights/index'
    assert_select 'select#from_airport'
    assert_select 'select#to_airport'
    assert_select 'select#date'
    assert_select 'select#num_tickets'
  end

  test "display flight results" do
    get flights_path, params: { from_airport: @flight.from_airport_id,
                               to_airport: @flight.to_airport_id,
                               date: @flight.date_formatted,
                               num_tickets: 1 }
    assert_template 'flights/index'
    assert_select 'td', @flight.from_airport.name
    assert_select 'td', @flight.to_airport.name
    assert_select 'td', @flight.date.strftime("%d %b %Y %H:%M")
    assert_select 'td', @flight.duration
  end
end
