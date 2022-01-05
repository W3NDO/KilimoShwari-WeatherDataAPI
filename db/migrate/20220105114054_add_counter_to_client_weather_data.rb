class AddCounterToClientWeatherData < ActiveRecord::Migration[6.1]
  def change
    add_column :client_weather_data, :counter, :integer
  end
end
