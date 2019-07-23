require 'test_helper'

class TarckerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tarcker_index_url
    assert_response :success
  end

end
