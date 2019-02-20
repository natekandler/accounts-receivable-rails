class InvoicePresenter
  attr_reader :convert
  
  def initialize convert=nil
    @convert = convert
  end

  def group_line_items invoice
    (
      line_items_with_totals(invoice.product_line_items, "product") +
      line_items_with_totals(invoice.service_line_items, "service")
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
    price_cents = type == "product" ? line_item.product.price_cents : line_item.service.price_cents
    line_item.price_override_cents || price_cents
  end

  def calculate_subtotal line_item, type
    calculate_unit_price(line_item, type) * line_item.quantity
  end

  # TODO: I think with a bit of changes to subtotal so the subtotal method doesn't
  # return a string this could updated to be cleaner, 
  # but it wasn't my main concern with the refactor 
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
  # TODO: I wasn't sure where this belonged anymore 
  #since it was only being used in the show view
  def to_money(cents)
    if convert
      conversion_rate = rate_service.get_rate
      puts "conversion rate #{conversion_rate}"
      "¥#{(conversion_rate * cents).to_i.to_s.insert(-3, ".")}"
    else
    "$#{cents.to_s.insert(-3, ".")}"
    end
  end

  def rate_service
    @rate_service || RateService.new
  end
end
