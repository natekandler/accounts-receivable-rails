class SetItemTypesOnLineItems < ActiveRecord::Migration[5.1]
  LineItem.all.each do |item|
    if item.product_id
      item.item_type = "product"
    else
      item.item_type = "service"
    end
    item.save
  end
end
