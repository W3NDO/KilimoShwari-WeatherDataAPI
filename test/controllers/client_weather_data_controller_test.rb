require "test_helper"

class ClientWeatherDataControllerTest < ActionDispatch::IntegrationTest
  test "Create new weather Data" do
    @user = users(:john)
    sign_in @user
    new_weather_data = ClientWeatherDatum.new(
      name: "Test Data",
      geo_location: "-1.1019714,37.0102091",
      start_date: 1641633104,
      end_date: 1643101904,
      user_id: @user.id,
      policy_id: 1,
      counter: nil
    )
      assert new_weather_data.save
  end

end
