FactoryBot.define do
   factory :bulk_discount, class: BulkDiscount do
     discount { [0.20, 0.15, 0.10, 0.30].sample }
        min_quantity { [10, 15, 20].sample }
        merchant
   end
 end
