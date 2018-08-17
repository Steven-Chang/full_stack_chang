require 'test_helper'

class WeeklySummariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weekly_summary = weekly_summaries(:one)
  end

  test "should get index" do
    get weekly_summaries_url
    assert_response :success
  end

  test "should get new" do
    get new_weekly_summary_url
    assert_response :success
  end

  test "should create weekly_summary" do
    assert_difference('WeeklySummary.count') do
      post weekly_summaries_url, params: { weekly_summary: {  } }
    end

    assert_redirected_to weekly_summary_url(WeeklySummary.last)
  end

  test "should show weekly_summary" do
    get weekly_summary_url(@weekly_summary)
    assert_response :success
  end

  test "should get edit" do
    get edit_weekly_summary_url(@weekly_summary)
    assert_response :success
  end

  test "should update weekly_summary" do
    patch weekly_summary_url(@weekly_summary), params: { weekly_summary: {  } }
    assert_redirected_to weekly_summary_url(@weekly_summary)
  end

  test "should destroy weekly_summary" do
    assert_difference('WeeklySummary.count', -1) do
      delete weekly_summary_url(@weekly_summary)
    end

    assert_redirected_to weekly_summaries_url
  end
end
