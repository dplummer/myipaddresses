require 'test_helper'

class IpsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ip" do
    assert_difference('Ip.count') do
      post :create, :ip => { }
    end

    assert_redirected_to ip_path(assigns(:ip))
  end

  test "should show ip" do
    get :show, :id => ips(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ips(:one).to_param
    assert_response :success
  end

  test "should update ip" do
    put :update, :id => ips(:one).to_param, :ip => { }
    assert_redirected_to ip_path(assigns(:ip))
  end

  test "should destroy ip" do
    assert_difference('Ip.count', -1) do
      delete :destroy, :id => ips(:one).to_param
    end

    assert_redirected_to ips_path
  end
end
