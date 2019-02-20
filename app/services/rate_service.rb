class RateService
  attr_reader :client
  def initialize
    @client = ForexDataClient.new(ENV['FOREX_KEY'])
  end

  def get_rate
    rates = client.getQuotes(["USDJPY"])
    rates.first["price"]
  end
end