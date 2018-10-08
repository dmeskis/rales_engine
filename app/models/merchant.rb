class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(quantity = 5)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group("merchants.id")
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity = 5)
    select("merchants.*")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group("merchants.id")
    .order("SUM(invoice_items.quantity) DESC")
    .limit(quantity)
  end

  def self.total_revenue(params)
    total =  joins(invoices: [:invoice_items, :transactions])
              .where(transactions: {result: 'success' })
              .where("merchants.id = ?", params["id"])
              .sum("invoice_items.quantity * invoice_items.unit_price")

    {"revenue" => "#{total.to_f}"}
  end

  def self.all_total_revenue_by_date(params)
    total = joins(invoices: [:invoice_items, :transactions])
            .where(transactions: {result: 'success'})
            .where(invoices: {created_at: params["date"].to_date.beginning_of_day..params["date"].to_date.end_of_day})
            .sum("invoice_items.quantity * invoice_items.unit_price")

    {"total_revenue" => "#{total.to_f}"}
  end

  def self.total_revenue_by_date(params)
    total = joins(invoices: [:invoice_items, :transactions])
            .where(transactions: {result: 'success' })
            .where(invoices: {created_at: params["date"].to_date.beginning_of_day..params["date"].to_date.end_of_day})
            .where("merchants.id = ?", params["id"])
            .sum("invoice_items.quantity * invoice_items.unit_price")

    {"revenue" => "#{total.to_f}"}
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
