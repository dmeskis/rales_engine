require 'rails_helper'

describe 'customers API' do
  it 'sends a list of customer' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
  it 'sends a single customer' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(Customer.count).to eq(1)
    expect(body["first_name"]).to eq(customer.first_name)
  end
  it 'sends a collection of associated invoices' do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.first["status"]).to eq(invoice_1.status)
    expect(body.last["status"]).to eq(invoice_2.status)
  end
  it 'sends a collection of associated transactions' do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body.first["credit_card_number"]).to eq(transaction_1.credit_card_number)
    expect(body.last["credit_card_number"]).to eq(transaction_2.credit_card_number)
  end
end
