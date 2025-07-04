require "test_helper"

class PhrasebookEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get phrasebook_entries_index_url
    assert_response :success
  end

  test "should get create" do
    get phrasebook_entries_create_url
    assert_response :success
  end

  test "should get destroy" do
    get phrasebook_entries_destroy_url
    assert_response :success
  end
end
