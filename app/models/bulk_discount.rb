class BulkDiscount < ApplicationRecord
  validates_presence_of :discount,
                        :min_quantity,
                        :merchant_id
  belongs_to :merchant
end
