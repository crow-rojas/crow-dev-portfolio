require "test_helper"

class LocalesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get locales_update_url
    assert_response :success
  end
end
