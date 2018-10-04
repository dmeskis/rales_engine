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

end
