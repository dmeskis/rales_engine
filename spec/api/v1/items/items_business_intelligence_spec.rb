require 'rails_helper'

describe 'items API' do
  it 'returns the top x items ranked by total revenue generated' do
    create_list(:item, 10)

    get '/api/v1/items/most_revenue?quantity=5'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(5)
  end
end
