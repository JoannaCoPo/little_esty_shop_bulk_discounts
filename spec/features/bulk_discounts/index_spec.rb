require 'rails_helper'

RSpec.describe 'bulk discounts index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Fancy Petz")
    @bulk_discount_1 = @merchant_1.bulk_discounts.create!(discount: 20, min_quantity: 15)
    @bulk_discount_2 = @merchant_1.bulk_discounts.create!(discount: 10, min_quantity: 10)
    @bulk_discount_3 = @merchant_1.bulk_discounts.create!(discount: 30, min_quantity: 20)
    # @bulk_discount_3 = FactoryBot.create(:bulk_discount
    # @bulk_discount_1 = @merchant1.bulk_discounts.create!(discount: )
    # @bulk_discount_2 = FactoryBot.create(:bulk_discount, merchant: @merchant_1)
    # @bulk_discount_3 = FactoryBot.create(:bulk_discount)

    visit merchant_bulk_discounts_path(@merchant_1)
  end

  it 'displays all of a merchants bulk discounts with their attributes' do
    expect(page).to have_content(@merchant_1.name)

    expect(page).to have_content(@bulk_discount_1.discount)
    expect(page).to have_content(@bulk_discount_1.min_quantity)
    expect(page).to have_content(@bulk_discount_2.discount)
    expect(page).to have_content(@bulk_discount_2.min_quantity)
    expect(page).to have_content(@bulk_discount_3.discount)
    expect(page).to have_content(@bulk_discount_3.min_quantity)
  end

  it 'lists a link to its show page for every bulk discount' do
    expect(page).to have_link("Discount ID #{@bulk_discount_2.id}")
    click_link("Discount ID #{@bulk_discount_2.id}")
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_2))
  end

  it 'has a section that lists the next 3 upcoming holidays via an API' do
  next_3_holidays = PublicHolidayService.new.upcoming_3_holidays.map{|holiday| holiday[:name]}

    within '#holidays' do
      expect(page).to have_content('Upcoming Holidays')
      expect(page).to have_content(next_3_holidays.first)
      expect(page).to have_content(next_3_holidays.second)
      expect(page).to have_content(next_3_holidays.third)
    end
  end

  it 'has a link to create a new discount that redirects to form' do
    within '#new-discount' do
      expect(page).to have_link('Create New Bulk Discount')
      click_link('Create New Bulk Discount')
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
    end
  end

  it 'has a link to delete the bulk discount' do
    within("#bulk_discount-#{@bulk_discount_1.id}") do
      expect(page).to have_button( "Delete Bulk Discount")
    end

    within("#bulk_discount-#{@bulk_discount_2.id}") do
      expect(page).to have_button( "Delete Bulk Discount")
    end

    within("#bulk_discount-#{@bulk_discount_3.id}") do
      expect(page).to have_button( "Delete Bulk Discount")
    end
  end

  it 'link to delete the bulk discount redirects to index where item is no longer listed' do
    within("#bulk_discount-#{@bulk_discount_1.id}") do
      save_and_open_page
      expect(page).to have_button( "Delete Bulk Discount")
      click_button 'Delete Bulk Discount'
    end

    expect(page).to_not have_content(@bulk_discount_1.discount)
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
  end
end
