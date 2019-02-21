class InvoicePresenter
  attr_reader :convert
  
  def initialize convert=nil
    @convert = convert
  end

  def group_line_items invoice
    (
      line_items_with_totals(invoice.product_line_items, :product) +
      line_items_with_totals(invoice.service_line_items, :service)
    ).group_by { |line_item| line_item.service.present? ? :service : :product }
  end

  def line_items_with_totals line_items, type
    line_items.map do |line_item|
      line_item.unit_price = to_money(calculate_unit_price(line_item, type))
      line_item.subtotal = to_money(calculate_subtotal(line_item, type))
      line_item
    end
  end

  def calculate_unit_price line_item, type
    price_cents = type == :product ? line_item.product.price_cents : line_item.service.price_cents
    line_item.price_override_cents || price_cents
  end

  def calculate_subtotal line_item, type
    calculate_unit_price(line_item, type) * line_item.quantity
  end

  def calculate_total line_items
    total = line_items.values.flatten.map { |line_item|
      [line_item.price_override_cents ||
       line_item&.product&.price_cents ||
       line_item&.service&.price_cents, line_item.quantity]
    }.sum { |(price_cents, quantity)|
      price_cents * quantity
    }
    to_money(total)
  end

  private 

  def to_money(cents)
    if convert
      cents_to_yen(cents)
    else
      cents_to_dollars(cents)
    end
  end

  def cents_to_yen cents
    conversion_rate = rate_service.get_rate
    "¥#{(conversion_rate * cents).to_i.to_s.insert(-3, ".")}"
  end

  def cents_to_dollars cents
    "$#{cents.to_s.insert(-3, ".")}"
  end

  def rate_service
    @rate_service || RateService.new
  end
end
