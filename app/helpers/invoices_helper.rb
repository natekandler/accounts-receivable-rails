module InvoicesHelper
  def to_money(cents)
    "$#{cents.to_s.insert(-3, ".")}"
  end
end
