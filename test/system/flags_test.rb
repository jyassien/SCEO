require "application_system_test_case"

class FlagsTest < ApplicationSystemTestCase
  setup do
    @flag = flags(:one)
  end

  test "visiting the index" do
    visit flags_url
    assert_selector "h1", text: "Flags"
  end

  test "should create flag" do
    visit flags_url
    click_on "New flag"

    fill_in "Description", with: @flag.description
    fill_in "Event", with: @flag.event_id
    fill_in "Flagged at", with: @flag.flagged_at
    fill_in "Reason", with: @flag.reason
    fill_in "User", with: @flag.user_id
    click_on "Create Flag"

    assert_text "Flag was successfully created"
    click_on "Back"
  end

  test "should update Flag" do
    visit flag_url(@flag)
    click_on "Edit this flag", match: :first

    fill_in "Description", with: @flag.description
    fill_in "Event", with: @flag.event_id
    fill_in "Flagged at", with: @flag.flagged_at
    fill_in "Reason", with: @flag.reason
    fill_in "User", with: @flag.user_id
    click_on "Update Flag"

    assert_text "Flag was successfully updated"
    click_on "Back"
  end

  test "should destroy Flag" do
    visit flag_url(@flag)
    click_on "Destroy this flag", match: :first

    assert_text "Flag was successfully destroyed"
  end
end
