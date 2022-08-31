class AddSessionTokenToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :session_token, :string
  end
end
