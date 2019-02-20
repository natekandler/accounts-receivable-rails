class Invoice < ApplicationRecord
  belongs_to :client
  has_many :line_items

  def product_line_items
    line_items.joins(:product).where("#{"products"}.price_cents != 0")
  end
  
  def service_line_items
    line_items.joins(:service).where('services.price_cents != 0')
  end
end
