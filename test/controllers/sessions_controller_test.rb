require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  token = ''
  @id = 0

  test "create new User" do
    user = User.new(
        email: "email@example.com",
        password:"foobar123", 
        password_confirmation:"foobar123"
    )
    if user.save
        @id = user.id
        puts "ID :: #{@id}"
        assert true    
    end
  end

  test "login User" do
    post "/api/v1/auth", params: {email: "email@example.com", password: "foobar123"}
    assert_response :success
  end
end