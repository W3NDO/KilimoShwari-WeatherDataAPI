class AddCoordinatesToPolicy < ActiveRecord::Migration[6.1]
  def change
    add_column :policies, :coordinates, :string
  end
end
