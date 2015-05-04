require 'test_helper'

class DronesControllerTest < ActionController::TestCase
  setup do
    @drone = drones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drone" do
    assert_difference('Drone.count') do
      post :create, drone: { title: @drone.title, tv_user: @drone.tv_user }
    end

    assert_redirected_to drone_path(assigns(:drone))
  end

  test "should show drone" do
    get :show, id: @drone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drone
    assert_response :success
  end

  test "should update drone" do
    patch :update, id: @drone, drone: { title: @drone.title, tv_user: @drone.tv_user }
    assert_redirected_to drone_path(assigns(:drone))
  end

  test "should destroy drone" do
    assert_difference('Drone.count', -1) do
      delete :destroy, id: @drone
    end

    assert_redirected_to drones_path
  end
end
