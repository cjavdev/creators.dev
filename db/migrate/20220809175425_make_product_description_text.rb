class MakeProductDescriptionText < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :description, :text
  end
end
