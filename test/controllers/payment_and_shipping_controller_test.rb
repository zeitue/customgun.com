require 'test_helper'

class PaymentAndShippingControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end
end
