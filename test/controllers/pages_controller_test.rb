require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get suck_tv_projects" do
    get :suck_tv_projects
    assert_response :success
  end

end
