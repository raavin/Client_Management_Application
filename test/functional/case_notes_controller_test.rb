require 'test_helper'

class CaseNotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:case_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case_note" do
    assert_difference('CaseNote.count') do
      post :create, :case_note => { }
    end

    assert_redirected_to case_note_path(assigns(:case_note))
  end

  test "should show case_note" do
    get :show, :id => case_notes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => case_notes(:one).to_param
    assert_response :success
  end

  test "should update case_note" do
    put :update, :id => case_notes(:one).to_param, :case_note => { }
    assert_redirected_to case_note_path(assigns(:case_note))
  end

  test "should destroy case_note" do
    assert_difference('CaseNote.count', -1) do
      delete :destroy, :id => case_notes(:one).to_param
    end

    assert_redirected_to case_notes_path
  end
end
