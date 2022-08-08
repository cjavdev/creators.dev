class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_enum :status, %w[
      pending
      processing
      processed
      failed
    ]
    create_table :events do |t|
      t.json :data
      t.string :source
      t.text :processing_errors
      t.enum(
        :status,
        enum_type: 'status',
        default: 'pending',
        null: false
      )
      t.timestamps
    end
  end
end
