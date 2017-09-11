class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :product, :optional => true
  belongs_to :service, :optional => true
end
