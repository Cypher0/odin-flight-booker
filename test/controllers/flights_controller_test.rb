require 'test_helper'

class FlightsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get flights_path
    assert_response :success
  end
end
