require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  it "determines whether a discount has been applied to an invoice item" do
    #remove instance variables if time
      @merchant_1 = Merchant.create!(name: 'Fanzy Petz')

      @item_1 = Item.create!(name: "Shampoo", description: "This washes dogs hair", unit_price: 6, merchant_id: @merchant_1.id, status: 1)
      @item_2 = Item.create!(name: "Butterfly Clip", description: "This makes dog hair fancy", unit_price: 4, merchant_id: @merchant_1.id)
      @bulk_discount_1 = @merchant_1.bulk_discounts.create!(discount: 10, min_quantity: 5)
      @bulk_discount_2 = @merchant_1.bulk_discounts.create!(discount: 15, min_quantity: 10)
      @bulk_discount_3 = @merchant_1.bulk_discounts.create!(discount: 20, min_quantity: 15)

      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @customer_2 = Customer.create!(first_name: 'Ima', last_name: 'Customer')

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2, created_at: "2012-03-28 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 50, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 2, status: 1)

      #increase unit_price for better visual
      
      expect(@invoice_1.total_discounted_revenue).to eq(227.0)
      expect(@ii_1.discount_condition).not_to eq(nil)
      expect(@ii_2.discount_condition).to eq(nil)
    end
  end
