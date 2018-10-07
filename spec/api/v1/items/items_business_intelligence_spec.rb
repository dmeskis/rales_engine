require 'rails_helper'

describe 'items API' do
  before(:each) do
    @invoice_item_1 = create(:invoice_item)
    @invoice_item_2 = create(:invoice_item)
    @invoice_item_3 = create(:invoice_item)
    @invoice_item_4 = create(:invoice_item)
    @invoice_item_5 = create(:invoice_item)
    @item_1 = @invoice_item_1.item
    @item_2 = @invoice_item_2.item
    @item_3 = @invoice_item_3.item
    @item_4 = @invoice_item_4.item
    @item_5 = @invoice_item_5.item
    @invoice_1 = @invoice_item_1.invoice
    @invoice_2 = @invoice_item_2.invoice
    @invoice_3 = @invoice_item_3.invoice
    @invoice_4 = @invoice_item_4.invoice
    @invoice_5 = @invoice_item_5.invoice
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
  end
  it 'returns the top x items ranked by total revenue generated' do

    get '/api/v1/items/most_revenue?quantity=5'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
  end
  it 'returns the top x items ranked by total number sold' do
    get '/api/v1/items/most_items?quantity=5'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(5)
  end
  # it 'returns the date with the most sales for the given item' do
  #   get "/api/v1/items/#{Item.first.id}/best_day"
  #
  #   expect(response).to be_successful
  #   body = JSON.parse(response.body)
  #   expect(body).to eq(Item.best_day("id" => Item.first.id))
  # end
end
