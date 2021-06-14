require 'rails_helper'

RSpec.describe 'merchant bulk discounts show' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Fancy Petz")
    @bulk_discount_1 = @merchant_1.bulk_discounts.create!(discount: 20, min_quantity: 15)
    @bulk_discount_2 = @merchant_1.bulk_discounts.create!(discount: 10, min_quantity: 10)
  end

  it 'displays the bulk discounts quantity threshold and percentage discount' do
    visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

    expect(page).to have_content(@bulk_discount_1.discount)
    expect(page).to have_content(@bulk_discount_1.min_quantity)

    visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_2)

    expect(page).to have_content(@bulk_discount_2.discount)
    expect(page).to have_content(@bulk_discount_2.min_quantity)
  end

  it 'displays a link that redirects to an edit form for the bulk discount' do
    visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
    within("#edit") do
      expect(page).to have_button("Edit Bulk Discount")
      click_button("Edit Bulk Discount")
    end

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
  end
end
