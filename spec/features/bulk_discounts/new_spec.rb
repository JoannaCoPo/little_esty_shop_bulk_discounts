require 'rails_helper'

RSpec.describe 'merchant bulk discounts new' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Fancy Petz")

    visit new_merchant_bulk_discount_path(@merchant_1)
  end

  it 'has a form to create a new bulk discount' do

    fill_in 'Discount', with: 50
    fill_in 'Min quantity', with: 25
    click_button 'submit'

    expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts")
    expect(page).to have_content(50.0)
    save_and_open_page
    expect(page).to have_content(25)
  end
end
