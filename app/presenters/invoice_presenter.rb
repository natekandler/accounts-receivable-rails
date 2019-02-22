class InvoicePresenter
  attr_reader :convert, :invoice, :raw_product_line_items, :raw_service_line_items
  
  def initialize args
    @convert = args.fetch(:convert)
    @invoice = args.fetch(:invoice)
    @raw_product_line_items = get_raw_product_line_items
    @raw_service_line_items = get_raw_service_line_items
  end

  def line_items
    {
      product: items_with_string_totals(raw_product_line_items), 
      service: items_with_string_totals(raw_service_line_items)
    }
  end

  def total
    raw_total = (raw_product_line_items + raw_service_line_items).inject(0) {|agg, item| agg += item.subtotal}
    rate_conversion_service.price_as_string(raw_total)
  end

  private 

  def get_raw_product_line_items
    invoice.product_line_items 
  end

  def get_raw_service_line_items
    invoice.service_line_items
  end

  def items_with_string_totals raw_line_items
    raw_line_items.map do |item|
      item.unit_price_string = rate_conversion_service.price_as_string(item.unit_price)
      item.subtotal_string = rate_conversion_service.price_as_string(item.subtotal)
      item
    end
  end

  def rate_conversion_service
    @rate_conversion_service || RateConversionService.new(convert)
  end
end
