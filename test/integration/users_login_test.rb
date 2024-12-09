require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ahmed)
  end

  test "with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
    assert_response :unprocessable_entity
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {
      session: {
        email: "ahmed@example.com",
        password: "password"
      }
    }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"

    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end
end
