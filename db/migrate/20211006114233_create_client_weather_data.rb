class CreateClientWeatherData < ActiveRecord::Migration[6.1]
  def change
    create_table :client_weather_data do |t|
      t.string :name
      t.string :geo_location
      t.text :weather_data
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
