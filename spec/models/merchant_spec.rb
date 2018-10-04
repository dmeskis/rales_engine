require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:transactions)}
    it {should have_many(:customers)}
    it {should have_many(:invoice_items)}
  end
  describe 'methods' do
    before(:each) do
      @merchant =  create(:merchant)
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @item_1 = create(:item, merchant:  @merchant)
      @item_2 = create(:item, merchant:  @merchant)
      @item_3 = create(:item, merchant:  @merchant)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, created_at: Faker::Date.backward(6))
      @invoice_2 = create(:invoice, customer: @customer_2, merchant: @merchant, created_at: Faker::Date.backward(3))
      @invoice_3 = create(:invoice, customer: @customer_1, merchant: @merchant, created_at: Faker::Date.backward(1))
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
      @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_3)
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: "failed")
      @transaction_2 = create(:transaction, invoice: @invoice_3, result: "success")
    end
    it 'total_revenue' do
      expect(Merchant.total_revenue({"id" => @merchant.id})).to eq(@invoice_item_1.unit_price * @invoice_item_1.quantity +
                                                         @invoice_item_3.unit_price * @invoice_item_3.quantity)
    end
    it 'total_revenue_by_date' do
      expect(Merchant.total_revenue_by_date({"id" => @merchant.id,
                                             "date" => @invoice_1.created_at}))
                                             .to eq(@invoice_item_1.unit_price * @invoice_item_1.quantity)
    end
    it 'favorite_customer' do
      expect(Merchant.favorite_customer({"id" => @merchant.id})).to eq(@customer_1)
    end
  end
end
