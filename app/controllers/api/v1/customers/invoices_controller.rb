class Api::V1::Customers::InvoicesController < ApplicationController
  include CustomerParams

  def index
    render json: Customer.find(customer_params[:id]).invoices
  end

end
