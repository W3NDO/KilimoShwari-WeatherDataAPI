class AddPolicyIdToContractsAsForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_reference :contracts, :policy, null: false, foreign_key: true
  end
end
