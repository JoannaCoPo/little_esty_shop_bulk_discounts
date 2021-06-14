require 'rails_helper'

describe BulkDiscount do
  describe "relationships" do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of(:discount)}
    it { should validate_presence_of(:min_quantity)}
    it { should validate_presence_of(:merchant_id)}
  end
end
