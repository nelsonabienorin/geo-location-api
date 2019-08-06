require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  file = File.read('Given_areas.json')
  # initialize test data
  let!(:given_areas) {  JSON.parse(file) }


  # Test suite for GET /areas
  describe 'GET /areas' do
    before { get '/areas' }

    it 'returns list of given areas' do
      expect(response).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end