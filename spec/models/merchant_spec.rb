require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
  end
  describe 'methods' do
    it 'total_revenue' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant:  merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, result: "success")

      expect(Merchant.total_revenue(merchant.id)).to eq(invoice_item.unit_price * invoice_item.quantity)
    end
  end
end
