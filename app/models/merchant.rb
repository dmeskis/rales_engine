class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.total_revenue(params)
    total =  joins(invoices: [:invoice_items, :transactions])
              .where(transactions: {result: 'success' })
              .where("merchants.id = ?", params["id"])
              .sum("invoice_items.quantity * invoice_items.unit_price")

    total.to_i
  end

  def self.total_revenue_by_date(params)
    total = joins(invoices: [:invoice_items, :transactions])
            .where(transactions: {result: 'success' })
            .where(invoices: {created_at: params["date"].to_date.beginning_of_day..params["date"].to_date.end_of_day})
            .where("merchants.id = ?", params["id"])
            .sum("invoice_items.quantity * invoice_items.unit_price")

    total.to_i
  end

  def self.favorite_customer(params)
    Customer.joins(:invoices, :transactions, :merchants)
    .where("merchants.id = ? AND transactions.result = ?", params["id"], 'success')
    .group("customers.id")
    .order(Arel.sql("COUNT(transactions.id) DESC"))
    .limit(1)
    .first
  end
end
