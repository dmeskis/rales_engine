class Api::V1::InvoiceItems::SearchController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.single_finder(invoice_item_params)
  end

  def index
    render json: InvoiceItem.find_all(invoice_item_params)
  end

end
