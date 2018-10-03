require 'rails_helper'

describe 'merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)

  end
  it 'can show a single merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(Merchant.count).to eq(1)
    expect(body["name"]).to eq(Merchant.first.name)
  end
  it 'can show a collection of items associated with that merchant' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.first["name"]).to eq(item_1.name)
    expect(body.first["description"]).to eq(item_1.description)
    expect(body.last["name"]).to eq(item_2.name)
    expect(body.last["description"]).to eq(item_2.description)
  end
  it 'can show a collection of invoices associated with that merchant' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.first["merchant_id"]).to eq(merchant.id)
    expect(body.first["customer_id"]).to eq(customer.id)
    expect(body.last["merchant_id"]).to eq(merchant.id)
    expect(body.last["customer_id"]).to eq(customer.id)
  end
end
