class ChangeDateToIntType < ActiveRecord::Migration[6.1]
  def change
    change_table :policies do |t|
      t.remove_column :start_date
      t.remove_column :end_date
    end
    add_column :policies, :start_date :integer
    add_column :policies, :end_date :integer
  end
end
