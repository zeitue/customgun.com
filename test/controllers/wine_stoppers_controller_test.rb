require 'test_helper'

class WineStoppersControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end
end
