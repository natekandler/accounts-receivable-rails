class RateConversionService
  attr_reader :convert

  def initialize convert
    @convert = convert
  end

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