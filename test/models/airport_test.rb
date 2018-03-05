require 'test_helper'

class AirportTest < ActiveSupport::TestCase

  def setup
    @airport = Airport.new(name: "Pärnu Airport", code: "EPU")
  end

  test "should be valid" do
    assert @airport.valid?
  end

  test "name should be present" do
    @airport.name = ''
    assert_not @airport.valid?
  end

  test "name should not be too long" do
    @airport.name = 'a' * 51
    assert_not @airport.valid?
  end

  test "code should be present" do
    @airport.code = ''
    assert_not @airport.valid?
  end

  test "code should be the right length" do
    @airport.code = "aa"
    assert_not @airport.valid?
    @airport.code = "aaaa"
    assert_not @airport.valid?
  end

  test "code validation should accept valid codes" do
    valid_codes = ["QWE", "rty", "uIo", "Asd"]
    valid_codes.each do |code|
      @airport.code = code
      assert @airport.valid?
    end
  end

  test "code validation should reject invalid codes" do
    invalid_codes = ["123", "AB1", "1bb", "RT@"]
    invalid_codes.each do |code|
      @airport.code = code
      assert_not @airport.valid?
    end
  end

  test "code should be unique" do
    @other_airport = @airport.dup
    @airport.save
    assert_not @other_airport.valid?
  end

  test "code should be upcased before saving" do
    mixed_code = "epU"
    @airport.code = mixed_code
    @airport.save
    assert_equal mixed_code.upcase, @airport.reload.code
  end
end
