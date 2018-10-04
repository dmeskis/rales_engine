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
end
