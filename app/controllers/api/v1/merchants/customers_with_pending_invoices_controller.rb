class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  include MerchantParams

  def index
    render json: Merchant.customers_with_pending_invoices(merchant_params["id"])
  end

end
