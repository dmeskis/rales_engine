require 'rails_helper'

describe 'merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)

  end
  it 'sends a single merchant' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(Merchant.count).to eq(1)
    expect(body["name"]).to eq(merchant.name)
  end
  it 'sends a collection of items associated with that merchant' do
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
  it 'sends a collection of invoices associated with that merchant' do
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
  it 'allows a user to find a merchant with a single finder' do
    create_list(:merchant, 2)
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(merchant.name)

    get "/api/v1/merchants/find?name=#{merchant.name}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(merchant.name)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    binding.pry
    expect(body["created_at"]).to eq(merchant.created_at)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["updated_at"]).to eq(merchant.updated_at)
  end
  xit 'allows a user to find all merchants with a multi finder' do
    merchants = create_list(:merchant, 3)
    duplicate_merchant = create(:merchant, name: merchants.first.name)

    get "/api/v1/merchants/find_all?#{merchants.first.id}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body["name"]).to eq(merchant.first.name)

    get "/api/v1/merchants/find_all?#{merchant.name}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
    expect(body["name"]).to eq(duplicate_merchant.name)
  end
end
