class AddItemTypeToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :item_type, :integer
  end
end
