require 'csv'

namespace :import do
  desc "TODO"
  task merchants: :environment do
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end

end
