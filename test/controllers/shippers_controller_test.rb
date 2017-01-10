require 'test_helper'

class ShippersControllerTest < ActionController::TestCase
  setup do
    @shipper = shippers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shippers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipper" do
    assert_difference('Shipper.count') do
      post :create, shipper: { address_id: @shipper.address_id, company_name: @shipper.company_name, fedex: @shipper.fedex, handling_fee: @shipper.handling_fee, name: @shipper.name, price: @shipper.price, scheme: @shipper.scheme, up_charge_rate: @shipper.up_charge_rate, ups: @shipper.ups, usps: @shipper.usps }
    end

    assert_redirected_to shipper_path(assigns(:shipper))
  end

  test "should show shipper" do
    get :show, id: @shipper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipper
    assert_response :success
  end

  test "should update shipper" do
    patch :update, id: @shipper, shipper: { address_id: @shipper.address_id, company_name: @shipper.company_name, fedex: @shipper.fedex, handling_fee: @shipper.handling_fee, name: @shipper.name, price: @shipper.price, scheme: @shipper.scheme, up_charge_rate: @shipper.up_charge_rate, ups: @shipper.ups, usps: @shipper.usps }
    assert_redirected_to shipper_path(assigns(:shipper))
  end

  test "should destroy shipper" do
    assert_difference('Shipper.count', -1) do
      delete :destroy, id: @shipper
    end

    assert_redirected_to shippers_path
  end
end
