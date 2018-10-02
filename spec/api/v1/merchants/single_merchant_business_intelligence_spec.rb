require 'rails_helper'

describe 'merchant api' do
  describe 'for a single merchant' do
    it 'returns total revenue for a single merchant' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant:  merchant)
      item_2 = create(:item, merchant:  merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
      transaction = create(:transaction, invoice: invoice, result: "success")
      transaction = create(:transaction, invoice: invoice, result: "failed")

      get "/api/v1/merchants/#{merchant.id}/revenue"

      expect(response).to be_successful

      revenue = JSON.parse(response.body)

      expect(revenue).to eq(Merchant.total_revenue(merchant.id))

    end
  end
end
