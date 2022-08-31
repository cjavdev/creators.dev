class RemoveStoreEmailIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :customers, [:store_id, :email], name: :index_customers_on_store_id_and_email
  end
end
