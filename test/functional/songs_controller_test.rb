require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  test "should get next" do
    get :next
    assert_response :success
  end

end
