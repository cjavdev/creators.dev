class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :stripe_id
      t.boolean :payouts_enabled
      t.boolean :charges_enabled
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
