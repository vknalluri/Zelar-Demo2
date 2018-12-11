require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  # Test suite for GET /api/v1/devise_users
  describe 'GET /api/v1/devise_users' do
    # make HTTP get request before each example
    before { get '/api/v1/devise_users' }

    it 'returns users' do
      result = JSON(response)
      expect(response).to have_http_status(:success)
      expect(result).not_to be_empty
      expect(result.length).to be >= 0
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
