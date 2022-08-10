class CreateAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :attachments do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.integer :views_count

      t.timestamps
    end
  end
end
