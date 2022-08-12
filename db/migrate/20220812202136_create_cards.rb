class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :stripe_id
      t.references :cardholder, null: false, foreign_key: true
      t.json :data
      t.string :last4

      t.timestamps
    end
  end
end
