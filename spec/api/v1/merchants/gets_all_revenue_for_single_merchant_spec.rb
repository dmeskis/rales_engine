require 'rails_helper'

describe 'merchant api' do
  describe 'for a single merchant' do
    it 'returns total revenue for a single merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}/revenue"
      
      expect(response).to be_successful


    end
  end
end
