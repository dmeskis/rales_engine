require 'rails_helper'

describe 'merchant api' do
  before(:each) do
    @merchant =  create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @item_1 = create(:item, merchant:  @merchant)
    @item_2 = create(:item, merchant:  @merchant)
    @item_3 = create(:item, merchant:  @merchant)
    @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant)
    @invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant)
    @invoice_3 = create(:invoice, customer: @customer_2, merchant: @merchant)
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_2 = create(:invoice_item, item: @item_3, invoice: @invoice_3)
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "failed")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
  end
  describe 'for a single merchant' do
    it 'returns total revenue for a single merchant' do
      get "/api/v1/merchants/#{@merchant.id}/revenue"

      expect(response).to be_successful

      revenue = JSON.parse(response.body)

      expect(revenue).to eq(Merchant.total_revenue(@merchant.id))

    end
    it 'returns the customer who has conducted the most total number of successful transactions' do

    end
  end
end
