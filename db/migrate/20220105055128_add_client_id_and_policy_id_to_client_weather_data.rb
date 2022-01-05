class AddClientIdAndPolicyIdToClientWeatherData < ActiveRecord::Migration[6.1]
  def change
    add_reference :client_weather_data, :user, null: false, foreign_key: true
    add_column :client_weather_data, :policy_id, :integer
  end
end
