class AddBlockHashToContract < ActiveRecord::Migration[6.1]
  def change
    add_column :contracts, :blockhash, :string
  end
end
