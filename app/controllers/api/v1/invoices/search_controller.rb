class Api::V1::Invoices::SearchController < ApplicationController
  include InvoiceParams

  def show
    render json: Invoice.find_by(invoice_params)
  end

  def index
    render json: Invoice.find_all(invoice_params)
  end

end