class ChangeDateToIntType < ActiveRecord::Migration[6.1]
  def change
    change_table :policies do |t|
      t.change :start_date, :integer
      t.change :end_date, :integer
    end
  end
end
