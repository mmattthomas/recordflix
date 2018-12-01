require 'test_helper'

class MessagingControllerTest < ActionDispatch::IntegrationTest
  test "should get getsms" do
    get messaging_getsms_url
    assert_response :success
  end

end
