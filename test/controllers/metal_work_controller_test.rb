require 'test_helper'

class MetalWorkControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
