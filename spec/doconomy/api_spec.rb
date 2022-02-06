# frozen_string_literal: true

RSpec.describe Doconomy::Api do
  describe '#configuration' do
    it 'should return default configuration' do
      expect(Doconomy::Api.configuration.environment).to eq(:sandbox)
      expect(Doconomy::Api.configuration.api_version).to eq(Doconomy::Api::VERSION)
      expect(Doconomy::Api.configuration.pem_password).to eq(nil)
    end

    context 'for a string scope' do
      let(:scope) { 'urn:aland-index:calculations,urn:aland-index:calculations:water-use' }

      it 'should return default configuration' do
        expect(Doconomy::Api.configuration.scope).to eq(scope)
      end
    end

    context 'for an array of scopes' do
      let(:scope) { %w(urn:aland-index:calculations urn:aland-index:calculations:water-use) }

      it 'should return default configuration' do
        expect(Doconomy::Api.configuration.scope).to eq(scope.join(','))
      end
    end
  end

  describe '#current_token' do
    context 'when token expired' do
      let(:current_token) { Doconomy::Api::Token.new(expires_in: -180) }
      let(:new_token) { Doconomy::Api::Token.new(expires_in: 180, access_token: 'valid') }

      before { Doconomy::Api.current_token = current_token }

      it 'should create new token' do
        expect(Doconomy::Api::Token).to receive(:create).and_return(new_token)
        Doconomy::Api.current_token.access_token
      end
    end

    context 'when token is not present' do
      let(:new_token) { Doconomy::Api::Token.new(expires_in: 180, access_token: 'valid') }

      before { Doconomy::Api.current_token = new_token }

      it 'should create new token' do
        Doconomy::Api.current_token.access_token
      end
    end

    context 'when token is present and not expired' do
      let(:current_token) { Doconomy::Api::Token.new(expires_in: 180) }

      before { Doconomy::Api.current_token = current_token }

      it 'should create new token' do
        expect(Doconomy::Api::Token).not_to receive(:create)
        Doconomy::Api.current_token.access_token
      end
    end
  end
end
