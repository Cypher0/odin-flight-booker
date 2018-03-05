require 'test_helper'

class FlightTest < ActiveSupport::TestCase

  def setup
    @flight = Flight.new(from_airport_id: 1, to_airport_id: 2, date: Time.zone.now, duration: "10h10m")
  end

  test "should be valid" do
    assert @flight.valid?
  end

  test "should have a departing airport" do
    @flight.from_airport_id = nil
    assert_not @flight.valid?
  end

  test "should have an arriving airport" do
    @flight.to_airport_id = nil
    assert_not @flight.valid?
  end

  test "departing and arriving airports should be different" do
    @flight.to_airport_id = 1
    assert_not @flight.valid?
  end

  test "date should be present" do
    @flight.date = nil
    assert_not @flight.valid?
  end

  test "duration should be present" do
    @flight.duration = nil
    assert_not @flight.valid?
  end

  test "duration validation should accept valid strings" do
    valid_durations = ["00h00m", "76h54m", "99h59m"]
    valid_durations.each do |duration|
      @flight.duration = duration
      assert @flight.valid?
    end
  end

  test "duration validation should reject invalid strings" do
    invalid_durations = ["1h1m", "01h60m", "1234"]
    invalid_durations.each do |duration|
      @flight.duration = duration
      assert_not @flight.valid?
    end
  end
end
