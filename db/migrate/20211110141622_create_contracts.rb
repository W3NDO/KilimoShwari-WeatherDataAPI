class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.string :address
      t.string :maize_variety
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
