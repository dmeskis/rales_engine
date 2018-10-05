class Api::V1::Invoices::SearchController < ApplicationController
  include InvoiceParams

  def show
    render json: Invoice.single_finder(invoice_params)
  end

  def index
    render json: Invoice.where(invoice_params)
  end

end
