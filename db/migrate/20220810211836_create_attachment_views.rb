class CreateAttachmentViews < ActiveRecord::Migration[7.1]
  def change
    create_table :attachment_views do |t|
      t.references :attachment, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
