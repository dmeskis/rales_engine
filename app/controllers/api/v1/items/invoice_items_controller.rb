class Api::V1::Items::InvoiceItemsController < ApplicationController
  include ItemParams

  def index
    binding.pry
    render json: Item.find(item_params[:id]).invoice_items
  end

end
