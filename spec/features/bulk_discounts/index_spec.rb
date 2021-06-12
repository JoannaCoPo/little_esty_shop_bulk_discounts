require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)
    @bulk_discount_1 = FactoryBot.create(:bulk_discount)
    @bulk_discount_2 = FactoryBot.create(:bulk_discount)
    @bulk_discount_3 = FactoryBot.create(:bulk_discount)
    @bulk_discount_4 = FactoryBot.create(:bulk_discount)
    @bulk_discount_5 = FactoryBot.create(:bulk_discount)

    visit 
  end
end
