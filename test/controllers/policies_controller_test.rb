require "test_helper"

class PoliciesControllerTest < ActionDispatch::IntegrationTest   
    test "create new Policy" do
        @user = users(:john)
        sign_in @user
        policy = Policy.new(
            location: "K road",
            start_date: 1641633104,
            end_date: 1643101904,
            coordinates: "-1.1019714,37.0102091",
            maize_variety: "Hybrid Series 6",
            user_id: @user.id
        )
        assert policy.save
    end

    test "Get All Policies" do 
        @user = users(:john)
        sign_in @user
        get "/api/v1/policies"
        assert_response :success
    end

    test "buy a policy" do 
        @user = users(:john)
        sign_in @user
        post "/api/v1/policies", params: {policy: {location: "K road", start_date: 1641633104, end_date: 1643101904, coordinates: "-1.1019714,37.0102091", maize_variety: "Hybrid Series 6"}}
        assert_response :success
        puts "#{response.parsed_body}"
    end
end