require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end

  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end

    it 'total discounted revenue' do
      @merchant_1 = Merchant.create!(name: 'Fanzy Petz')

      @item_1 = Item.create!(name: "Shampoo", description: "This washes dogs hair", unit_price: 6, merchant_id: @merchant_1.id, status: 1)
      @item_2 = Item.create!(name: "Butterfly Clip", description: "This makes dog hair fancy", unit_price: 4, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: "Shears", description: "Creates fancy styles for your pet", unit_price: 25, merchant_id: @merchant_1.id)

      @bulk_discount_1 = @merchant_1.bulk_discounts.create!(discount: 10, min_quantity: 5)
      @bulk_discount_2 = @merchant_1.bulk_discounts.create!(discount: 15, min_quantity: 10)
      @bulk_discount_3 = @merchant_1.bulk_discounts.create!(discount: 20, min_quantity: 15)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @customer_2 = Customer.create!(first_name: 'Ima', last_name: 'Customer')

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2, created_at: "2012-03-28 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 11, unit_price: 6, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 18, unit_price: 4, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 25, status: 1)

      expect(@invoice_1.total_discounted_revenue).to eq(113.70)
      expect(@invoice_2.total_discounted_revenue).to eq(25.00)
    end
  end
end
