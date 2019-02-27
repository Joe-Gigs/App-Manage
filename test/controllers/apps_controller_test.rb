require 'test_helper'

class AppsControllerTest < ActionDispatch::IntegrationTest
  test "should get console" do
    get apps_console_url
    assert_response :success
  end

end
