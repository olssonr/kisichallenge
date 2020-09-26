require 'test_helper'

class EventControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get event_index_url
    assert_response :success
  end

  test "should get create" do
    get event_create_url
    assert_response :success
  end

end
