class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.total_revenue(merchant_id)
    total =  joins(invoices: [:invoice_items, :transactions])
              .where(transactions: {result: 'success' })
              .where("merchants.id = ?", merchant_id)
              .sum("invoice_items.quantity * invoice_items.unit_price")

    total.to_i
  end

  def self.total_revenue_by_date(params)
    total = joins(invoices: [:invoice_items, :transactions])
            .where(transactions: {result: 'success' })
            .where("invoices.created_at = ?", params["created_at"])
            .where("merchants.id = ?", params["merchant_id"])
            .sum("invoice_items.quantity * invoice_items.unit_price")

    total.to_i
  end

  def self.favorite_customer(merchant_id)
    Customer.joins(:invoices, :transactions, :merchants)
    .where("merchants.id = ? AND transactions.result = ?", merchant_id, 'success')
    .group("customers.id")
    .order(Arel.sql("COUNT(transactions.id) DESC"))
    .limit(1)
    .first
  end
end
