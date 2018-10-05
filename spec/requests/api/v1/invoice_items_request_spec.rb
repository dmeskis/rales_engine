require 'rails_helper'

describe 'invoice items API' do
  it 'sends a list of invoice items' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
  end
  it 'sends a single invoice_item' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(InvoiceItem.count).to eq(1)
    expect(body["invoice_id"]).to eq(invoice_item.invoice_id)
  end
  it 'sends associated invoice' do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["status"]).to eq(invoice.status)
  end
  it 'sends associated item' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["name"]).to eq(item.name)
  end
  it 'allows a user to find an invoice item with a single finder' do
    create_list(:invoice_item, 2)
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["quantity"]).to eq(invoice_item.quantity)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["quantity"]).to eq(invoice_item.quantity)

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["quantity"]).to eq(invoice_item.quantity)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"
    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["quantity"]).to eq(invoice_item.quantity)
  end
  xit 'allows a user to find all invoice_items with a multi finder' do
    invoice_items = create_list(:invoice_item, 3)
    duplicate_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?#{invoice_items.first.id}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body["quantity"]).to eq(invoice_item.first.quantity)

    get "/api/v1/invoice_items/find_all?#{invoice_item.name}"
    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
    expect(body["quantity"]).to eq(duplicate_invoice_item.quantity)
  end
end
