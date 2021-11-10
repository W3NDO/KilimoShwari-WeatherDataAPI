class CreatePolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :policies do |t|
      t.integer :client_id
      t.string :location
      t.string :maize_variety
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
