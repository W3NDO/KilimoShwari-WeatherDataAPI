class RemoveClientIdFromPolicy < ActiveRecord::Migration[6.1]
  def change
    remove_column :policies, client_id
  end
end
