class InvoicePresenter
  attr_reader :convert, :invoice
  
  def initialize args
    @convert = args.fetch(:convert)
    @invoice = args.fetch(:invoice)
  end

  def line_items
    (
      invoice.product_line_items +
      invoice.service_line_items
    ).group_by { |line_item| line_item.service.present? ? :service : :product }
  end

  def total
    line_items.values.flatten.inject(0) {|agg, item| agg += item.subtotal}
  end

  private 

  def price_as_string(cents)
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
