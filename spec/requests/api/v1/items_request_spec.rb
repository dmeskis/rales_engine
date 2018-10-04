require 'rails_helper'

describe 'items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end
  it 'sends a single invoice' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(Item.count).to eq(1)
    expect(body["name"]).to eq(item.name)
  end
  it 'sends a collection of associated invoice items' do
    item = create(:item)
    invoice_item_1 = create(:invoice_item, item: item)
    invoice_item_2 = create(:invoice_item, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.first["quantity"]).to eq(invoice_item_1.quantity)
    expect(body.last["quantity"]).to eq(invoice_item_2.quantity)
  end
end
