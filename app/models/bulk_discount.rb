class BulkDiscount < ApplicationRecord
  validates_presence_of :discount,
                        :min_quantity,
                        :merchant_id
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
end
