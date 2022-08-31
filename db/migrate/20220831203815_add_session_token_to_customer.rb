class AddSessionTokenToCustomer < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :session_token, :string
    add_column :customers, :token_expires_at, :datetime

    remove_index :customers, [:store_id, :email], name: :index_customers_on_store_id_and_email, unique: true
  end
end
