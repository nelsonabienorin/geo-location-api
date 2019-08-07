require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let(:parsed_response) { JSON.parse(response.body) }

  # Test suite for GET /areas
  describe 'GET /areas' do
    before { get '/areas' }
    context 'when given a list of  areas' do
      it 'returns response with appropriate keys' do
        expect(parsed_response.keys).to eq(%w(type features))
        expect(parsed_response['features'][0].keys).to eq(%w(type properties geometry))
        expect(parsed_response['features'][0]['geometry'].keys).to eq(%w(type coordinates))
      end

      it 'returns a response with point x-y coordinates' do
        expect(parsed_response['features'][0]['geometry']['coordinates'][0][0]).to eq([7.36083984375, 50.666872321810715])
      end

      it 'returns a non empty response' do
        expect(parsed_response).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a JSON response format' do
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  #Test suite for POST /areas
  describe 'POST /areas' do
    context 'when given a list of  areas with valid point input' do
      before { post '/areas', params: {point: {'0'=> '-105.8203125', '1'=> '35.0299963690256' } } }
      it 'returns a non empty response' do
        expect(parsed_response).not_to be_empty
      end

      it 'returns true if input is a valid point' do
        expect(parsed_response['type_point']).to be_truthy
      end

      it 'returns true if point input is located within the given areas' do
        expect(parsed_response['inside']).to be_truthy
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a JSON response format' do
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when given a list of  areas with invalid point input' do
      it 'returns status code 500 when input format is invalid' do
        post '/areas', params: {point: %w(102 78)}
        expect(response).to have_http_status(:internal_server_error)
      end

      it 'returns false when point is not located within given areas' do
        post '/areas', params: {point: {'0'=> '102', '1'=> '78' } }
        expect(parsed_response['inside']).to be_falsy
      end

      it 'returns false if input is not a valid point' do
        post '/areas', params: {point: {'0'=> '12', '1'=> '8', '2'=>'56' } }
        expect(parsed_response['type_point']).to be_falsy
      end

      it 'returns error message when input format is invalid' do
        post '/areas', params: {point: %w(18 56)}
        expect(parsed_response['message']).to match('Something went wrong: no implicit conversion of String into Integer')
      end
    end
  end
end