require 'test_helper'

class AimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aim = aims(:one)
  end

  test "should get index" do
    get aims_url
    assert_response :success
  end

  test "should get new" do
    get new_aim_url
    assert_response :success
  end

  test "should create aim" do
    assert_difference('Aim.count') do
      post aims_url, params: { aim: {  } }
    end

    assert_redirected_to aim_url(Aim.last)
  end

  test "should show aim" do
    get aim_url(@aim)
    assert_response :success
  end

  test "should get edit" do
    get edit_aim_url(@aim)
    assert_response :success
  end

  test "should update aim" do
    patch aim_url(@aim), params: { aim: {  } }
    assert_redirected_to aim_url(@aim)
  end

  test "should destroy aim" do
    assert_difference('Aim.count', -1) do
      delete aim_url(@aim)
    end

    assert_redirected_to aims_url
  end
end
