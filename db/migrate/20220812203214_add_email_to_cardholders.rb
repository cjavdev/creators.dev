class AddEmailToCardholders < ActiveRecord::Migration[7.1]
  def change
    add_column :cardholders, :email, :string
  end
end
