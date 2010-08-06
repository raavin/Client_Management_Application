require 'test_helper'

class WaitingListsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:waiting_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create waiting_list" do
    assert_difference('WaitingList.count') do
      post :create, :waiting_list => { }
    end

    assert_redirected_to waiting_list_path(assigns(:waiting_list))
  end

  test "should show waiting_list" do
    get :show, :id => waiting_lists(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => waiting_lists(:one).to_param
    assert_response :success
  end

  test "should update waiting_list" do
    put :update, :id => waiting_lists(:one).to_param, :waiting_list => { }
    assert_redirected_to waiting_list_path(assigns(:waiting_list))
  end

  test "should destroy waiting_list" do
    assert_difference('WaitingList.count', -1) do
      delete :destroy, :id => waiting_lists(:one).to_param
    end

    assert_redirected_to waiting_lists_path
  end
end
