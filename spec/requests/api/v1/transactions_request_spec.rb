require 'rails_helper'

describe 'transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end
  it 'sends a single transaction' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(Transaction.count).to eq(1)
    expect(body["credit_card_number"]).to eq(transaction.credit_card_number)
  end
  it 'sends the associated invoice' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["status"]).to eq(transaction.invoice.status)
  end
  it 'allows a user to find an transaction with a single finder' do
    create_list(:transaction, 2)
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["credit_card_number"]).to eq(transaction.credit_card_number)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["credit_card_number"]).to eq(transaction.credit_card_number)

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["credit_card_number"]).to eq(transaction.credit_card_number)

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["credit_card_number"]).to eq(transaction.credit_card_number)
  end
  xit 'allows a user to find all transactions with a multi finder' do
    transactions = create_list(:transaction, 3)
    duplicate_transaction = create(:transaction)

    get "/api/v1/transactions/find_all?#{transactions.first.id}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body["credit_card_number"]).to eq(transaction.first.credit_card_number)

    get "/api/v1/transactions/find_all?#{transaction.name}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
    expect(body["credit_card_number"]).to eq(duplicate_transaction.credit_card_number)
  end
end
