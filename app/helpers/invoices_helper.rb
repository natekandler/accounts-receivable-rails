module InvoicesHelper
  def to_money(cents, conversion_rate)
    if conversion_rate
      #converto yen
    else
    "$#{cents.to_s.insert(-3, ".")}"
    end
  end
end
