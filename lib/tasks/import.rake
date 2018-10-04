require 'csv'

namespace :import do
  desc "Imports all CSV data"
  task all: :environment do
    # The order these are being loaded is important due to model relationships
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      row[:unit_price] = row[:unit_price].to_f / 100
      Item.create!(row.to_h)
    end
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      row[:unit_price] = row[:unit_price].to_f / 100
      InvoiceItem.create!(row.to_h)
    end
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end
end
