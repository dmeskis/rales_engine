require 'rails_helper'

describe 'merchant api' do
  before(:each) do
    @merchant_1   = create(:merchant)
    @merchant_2   = create(:merchant)
    @merchant_3   = create(:merchant)
    @merchant_4   = create(:merchant)
    @merchant_5   = create(:merchant)
    @merchant_6   = create(:merchant)
    @merchant_7   = create(:merchant)
    @merchant_8   = create(:merchant)
    @merchant_9   = create(:merchant)
    @merchant_10  = create(:merchant)
    @item_1   = create(:item, merchant:  @merchant_1)
    @item_2   = create(:item, merchant:  @merchant_2)
    @item_3   = create(:item, merchant:  @merchant_3)
    @item_4   = create(:item, merchant:  @merchant_4)
    @item_5   = create(:item, merchant:  @merchant_5)
    @item_6   = create(:item, merchant:  @merchant_6)
    @item_7   = create(:item, merchant:  @merchant_7)
    @item_8   = create(:item, merchant:  @merchant_8)
    @item_9   = create(:item, merchant:  @merchant_9)
    @item_10  = create(:item, merchant:  @merchant_10)
    @invoice_1  = create(:invoice, merchant: @merchant_1)
    @invoice_2  = create(:invoice, merchant: @merchant_2)
    @invoice_3  = create(:invoice, merchant: @merchant_3)
    @invoice_4  = create(:invoice, merchant: @merchant_4)
    @invoice_5  = create(:invoice, merchant: @merchant_5)
    @invoice_6  = create(:invoice, merchant: @merchant_6)
    @invoice_7  = create(:invoice, merchant: @merchant_7)
    @invoice_8  = create(:invoice, merchant: @merchant_8)
    @invoice_9  = create(:invoice, merchant: @merchant_9)
    @invoice_10 = create(:invoice, merchant: @merchant_10)
    @invoice_item_1   = create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2   = create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_3   = create(:invoice_item, item: @item_3, invoice: @invoice_3)
    @invoice_item_4   = create(:invoice_item, item: @item_4, invoice: @invoice_4)
    @invoice_item_5   = create(:invoice_item, item: @item_5, invoice: @invoice_5)
    @invoice_item_6   = create(:invoice_item, item: @item_6, invoice: @invoice_6)
    @invoice_item_7   = create(:invoice_item, item: @item_7, invoice: @invoice_7)
    @invoice_item_8   = create(:invoice_item, item: @item_8, invoice: @invoice_8)
    @invoice_item_9   = create(:invoice_item, item: @item_9, invoice: @invoice_9)
    @invoice_item_10  = create(:invoice_item, item: @item_10, invoice: @invoice_10)
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: "success")
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: "success")
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: "success")
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: "failed")
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: "failed")
  end
  describe 'for all merchants' do
    it 'returns top x merchants by total revenue' do

      get "/api/v1/merchants/most_revenue?quantity=5"

      expect(response).to be_successful

      body = JSON.parse(response.body)
      merchants = Merchant.most_revenue()
      expect(body.count).to eq(5)
      # expect(body).to eq(merchants)

    end
  end
end
