class ChangeDateToIntType < ActiveRecord::Migration[6.1]
  def change
    # remove_column :policies, :start_date
    # remove_column :policies, :end_date
    # add_column :policies, :start_date, :integer
    # add_column :policies, :end_date, :integer

    remove_column :contracts, :start_date
    remove_column :contracts, :end_date
    add_column    :contracts, :start_date, :integer
    add_column    :contracts, :end_date, :integer

    # remove_column :client_weather_data, :start_date
    # remove_column :client_weather_data, :end_date
    # add_column    :client_weather_data, :start_date, :integer
    # add_column    :client_weather_data, :end_date, :integer
  end
end
