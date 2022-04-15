require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
                    
  describe 'GET /api/v1/profiles/me' do
    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
      let(:api_path) { '/api/v1/profiles/me' }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns all public fields' do
        %w[id email admin created_at updated_at].each do |attr|
          expect(json['user'][attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end

  describe 'GET /api/v1/profiles' do
    let(:api_path) { '/api/v1/profiles' }
    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token) }
      let!(:users) { create_list(:user, 2) }
      let(:user) { users.first }
      let(:user_response) { json['users'].first }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it_behaves_like 'Success requestable'

      it_behaves_like 'Public fields returnable' do
        let(:resource) { user }
        let(:resource_response) { user_response }
        let(:attrs) { %w[id email admin created_at updated_at]}
      end

      it 'returns all public fields' do
        %w[id email admin created_at updated_at].each do |attr|
          expect(user_response[attr]).to eq user.send(attr).as_json
        end
      end

      it_behaves_like 'Resource count returnable' do
        let(:resource_response) { json['users'] }
        let(:resource) { users }
      end

      it 'returns list of resources' do
        expect(json['users'].size).to eq users.size
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end
end
