class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.favorite_merchant(params)
    Merchant.joins(:customers, invoices: :transactions)
            .where("customers.id = ? AND transactions.result = ?", params["id"], 'success')
            .group("merchants.id")
            .order("COUNT(transactions.id) DESC")
            .limit(1)
            .first
  end

end
