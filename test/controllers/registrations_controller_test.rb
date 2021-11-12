require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    bob = {
        "email": "test@example.com"
    }

    test "register new User" do
        assert User.create(bob)
    end
end
