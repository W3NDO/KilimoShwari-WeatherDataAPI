class ChangeDateToIntType < ActiveRecord::Migration[6.1]
  def change
    change_table :policies do |t|
      t.remove_column :start_date
      t.remove_column :end_date
      t.add_column, :start_date, :integer
      t.add_column, :end_date, :integer
    end
  end
end
