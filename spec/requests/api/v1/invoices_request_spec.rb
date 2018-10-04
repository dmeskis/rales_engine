require 'rails_helper'

describe 'invoices API' do
  it 'sends a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end
  it 'sends a single invoice' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(Invoice.count).to eq(1)
    expect(body["merchant_id"]).to eq(invoice.merchant_id)
  end
  it 'sends a collection of associated transactions' do
    invoice = create(:invoice)
    transaction_1 = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    body= JSON.parse(response.body)
    expect(body.count).to eq(2)

    expect(body.first["credit_card_number"]).to eq(transaction_1.credit_card_number)
    expect(body.last["credit_card_number"]).to eq(transaction_2.credit_card_number)
  end
  it 'sends a collection of associated invoice_items' do
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice: invoice)
    invoice_item_2 = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    body= JSON.parse(response.body)
    expect(body.count).to eq(2)

    expect(body.first["quantity"]).to eq(invoice_item_1.quantity)
    expect(body.last["quantity"]).to eq(invoice_item_2.quantity)
  end
  it 'sends a collection of associated items' do
    invoice = create(:invoice)
    item_1 = create(:item)
    item_2 = create(:item)
    create(:invoice_item, invoice: invoice, item: item_1)
    create(:invoice_item, invoice: invoice, item: item_2)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    body= JSON.parse(response.body)
    expect(body.count).to eq(2)

    expect(body.first["description"]).to eq(item_1.description)
    expect(body.last["description"]).to eq(item_2.description)
  end
  it 'sends associated customer' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    body= JSON.parse(response.body)
    expect(body["first_name"]).to eq(invoice.customer.first_name)
  end
  it 'sends associated merchant' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    body= JSON.parse(response.body)
    expect(body["name"]).to eq(invoice.merchant.name)
  end
end
