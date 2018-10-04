require 'rails_helper'

describe 'invoice items API' do
  it 'sends a list of invoice items' do
    create_list(:invoice_items, 3)

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

end
