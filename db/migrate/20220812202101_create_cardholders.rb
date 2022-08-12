class CreateCardholders < ActiveRecord::Migration[7.1]
  def change
    create_table :cardholders do |t|
      t.string :stripe_id
      t.string :name
      t.json :data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
