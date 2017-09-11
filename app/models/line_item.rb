class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :product
  belongs_to :service
end
