class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :product, :optional => true
  belongs_to :service, :optional => true

  validate :must_be_product_or_service

  attr_accessor :unit_price_string, :subtotal_string
  enum item_type: [ :product, :service ]

  def must_be_product_or_service
    if product.blank? && service.blank?
      errors.add(:base, "A line item must be either a product or a service")
    elsif product.present? && service.present?
      errors.add(:base, "A line item can't be both a product and a service")
    end
  end

  def unit_price
    case item_type
    when "product"
      price_override_cents || product.price_cents
    when "service"
      price_override_cents || service.price_cents
    else
      nil
    end
  end

  def subtotal
    unit_price * quantity
  end

  def line_item_instance_variable

  end
end
