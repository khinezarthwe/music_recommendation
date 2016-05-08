require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title","Home| Music Recommendation"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title","Help| Music Recommendation"
  end
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title","About| Music Recommendation"
  end
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact| Music Recommendation"
  end
end
