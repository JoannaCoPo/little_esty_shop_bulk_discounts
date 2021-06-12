FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..20) }
    unit_price { rand(100..5000) }
    status { [0, 1, 2].sample }
  end
end
