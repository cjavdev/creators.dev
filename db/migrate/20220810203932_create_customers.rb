class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :stripe_id
      t.string :email, null: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end

    add_index :customers, [:store_id, :email], unique: true
  end
end
