require 'test_helper'

class SignatureRifleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
