class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates_presence_of :unit_price,
                        :description,
                        :name,
                        :merchant_id

  # def self.top_revenue_items(params)
  #   select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
  #   .joins(:invoice_items, invoice_items: :invoices)
  #   .where(transactions: {result: "success"})
  #   .order("revenue DESC")
  #   .group(:id)
  #   .limit(params["quantity"])
  # end
end
