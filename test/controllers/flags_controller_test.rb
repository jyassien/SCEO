require "test_helper"

class FlagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flag = flags(:one)
  end

  test "should get index" do
    get flags_url
    assert_response :success
  end

  test "should get new" do
    get new_flag_url
    assert_response :success
  end

  test "should create flag" do
    assert_difference("Flag.count") do
      post flags_url, params: { flag: { description: @flag.description, event_id: @flag.event_id, flagged_at: @flag.flagged_at, reason: @flag.reason, user_id: @flag.user_id } }
    end

    assert_redirected_to flag_url(Flag.last)
  end

  test "should show flag" do
    get flag_url(@flag)
    assert_response :success
  end

  test "should get edit" do
    get edit_flag_url(@flag)
    assert_response :success
  end

  test "should update flag" do
    patch flag_url(@flag), params: { flag: { description: @flag.description, event_id: @flag.event_id, flagged_at: @flag.flagged_at, reason: @flag.reason, user_id: @flag.user_id } }
    assert_redirected_to flag_url(@flag)
  end

  test "should destroy flag" do
    assert_difference("Flag.count", -1) do
      delete flag_url(@flag)
    end

    assert_redirected_to flags_url
  end
end
