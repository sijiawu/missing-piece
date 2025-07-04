require "test_helper"

class PhrasesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get phrases_create_url
    assert_response :success
  end
end
