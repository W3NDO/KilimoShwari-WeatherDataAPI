class ChangeDateToIntType < ActiveRecord::Migration[6.1]
  def change
    remove_column :policies, :start_date
    remove_column :policies, :end_date
    add_column :policies, :start_date, :integer
    add_column :policies, :end_date, :integer
  end
end
