require 'test_helper'

class PassengerTest < ActiveSupport::TestCase

  def setup
    @passenger = passengers(:test_passenger)
  end

  test "should be valid" do
    assert @passenger.valid?
  end

  test "name should exist" do
    @passenger.name = ''
    assert_not @passenger.valid?
  end

  test 'name should not be too long' do
    @passenger.name = 'a' * 51
    assert_not @passenger.valid?
  end

  test "email should exist" do
    @passenger.email = ''
    assert_not @passenger.valid?
  end

  test 'email should not be too long' do
    @passenger.email = "#{'a' * 244}@example.com"
    assert_not @passenger.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @passenger.email = valid_address
      assert @passenger.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @passenger.email = invalid_address
      assert_not @passenger.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
