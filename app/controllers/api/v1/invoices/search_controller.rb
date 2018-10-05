class Api::V1::Invoices::SearchController < ApplicationController
  include InvoiceParams

  def show
    render json: Invoice.single_finder(invoice_params)
  end

  def index
    render json: Invoice.multi_finder(invoice_params)
  end

end
