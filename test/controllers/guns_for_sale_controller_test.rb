require 'test_helper'

class GunsForSaleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
