class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates_presence_of :unit_price,
                        :description,
                        :name,
                        :merchant_id

  def self.top_revenue_items(quantity = 5)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})
    .order("revenue DESC")
    .group("items.id")
    .limit(quantity)
  end

  def self.most_sold_items(quantity = 5)
    joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})
    .group("items.id")
    .order("SUM(invoice_items.quantity)")
    .limit(quantity)
  end
end
