class RemoveStoreEmailIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :customers, name: :index_customers_on_store_id_and_email
  end
end
