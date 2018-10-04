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
  it 'allows a user to find a customer with a single finder' do
    create_list(:customer, 2)
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["first_name"]).to eq(customer.first_name)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["first_name"]).to eq(customer.first_name)

    get "/api/v1/customers/find?created_at=#{customer.created_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["first_name"]).to eq(customer.first_name)

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["first_name"]).to eq(customer.first_name)
  end
  xit 'allows a user to find all customers with a multi finder' do
    customers = create_list(:customer, 3)
    duplicate_customer = create(:customer)

    get "/api/v1/customers/find_all?#{customers.first.id}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body["first_name"]).to eq(customer.first.first_name)

    get "/api/v1/customers/find_all?#{customer.name}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
    expect(body["first_name"]).to eq(duplicate_customer.first_name)
  end
end
