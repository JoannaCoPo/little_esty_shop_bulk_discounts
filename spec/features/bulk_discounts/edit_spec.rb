require 'rails_helper'

RSpec.describe 'merchant bulk discounts edit' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Fancy Petz")
    @bulk_discount_1 = @merchant_1.bulk_discounts.create!(discount: 20, min_quantity: 15)

    visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
  end

  it 'has a form to create a new bulk discount' do
    expect(find('form')).to have_content("Discount")
    expect(find('form')).to have_content("Min quantity")

    fill_in 'Discount', with: 50
    fill_in 'Min quantity', with: 25
    click_button 'submit'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    expect(page).to_not have_content(20.0)
    expect(page).to_not have_content(15)
    expect(page).to have_content(50.0)
    expect(page).to have_content(25)
  end
end

# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
