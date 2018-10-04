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

end
