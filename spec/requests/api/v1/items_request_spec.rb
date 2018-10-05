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
  it 'sends the associated merchant' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(item.merchant.name)
  end
  it 'allows a user to find an item with a single finder' do
    create_list(:item, 2)
    item = create(:item, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/items/find?id=#{item.id}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(item.name)

    get "/api/v1/items/find?name=#{item.name}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(item.name)

    get "/api/v1/items/find?created_at=#{item.created_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(item.name)

    get "/api/v1/items/find?updated_at=#{item.updated_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(item.name)
  end
  it 'allows a user to find all items with a multi finder' do
    items = create_list(:item, 3)
    duplicate_item = create(:item, name: items.first.name, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-04-27 14:53:59 UTC")

    get "/api/v1/items/find_all?id=#{items.first.id}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body.count).to eq(1)
    expect(body.last["name"]).to eq(duplicate_item.name)

    get "/api/v1/items/find_all?name=#{items.first.name}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
    expect(body.first["name"]).to eq(duplicate_item.name)

    get "/api/v1/items/find_all?created_at=#{duplicate_item.created_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.last["name"]).to eq(duplicate_item.name)

    get "/api/v1/items/find_all?updated_at=#{duplicate_item.updated_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.first["name"]).to eq(duplicate_item.name)
  end
end
