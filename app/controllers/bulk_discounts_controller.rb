class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)

    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:incomplete] = 'You are missing one or more fields; please complete all fields to create a new discount.'
      redirect_to new_merchant_bulk_discount_path(merchant)
    end
  end

  private

  def bulk_discount_params
    params.fetch(:bulk_discount, {}).permit(:discount, :min_quantity, :merchant_id)
  end
end
