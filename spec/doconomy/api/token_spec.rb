# frozen_string_literal: true

RSpec.describe Doconomy::Api::Token, type: :sandbox do
  let(:scope) { ['urn:aland-index:calculations', 'urn:aland-index:calculations:water-use'] }
  let(:attributes) do
    {
      access_token: 'valid',
      scope: scope.join(','),
      token_type: 'bearer',
      expires_in: 180,
      error: 'test',
      error_description: 'test description'
    }
  end

  describe '#initialize' do
    let(:token) { Doconomy::Api::Token.new(attributes) }

    it 'should return access_token' do
      expect(token.access_token).to eq('valid')
    end

    it 'should return scope' do
      expect(token.scope).to eq(scope.join(','))
    end

    it 'should return token_type' do
      expect(token.token_type).to eq('bearer')
    end

    it 'should return expires_in' do
      expect(token.expires_in).to eq(180)
    end

    it 'should return expires_at' do
      expect(token.expires_at).to be_present
    end

    it 'should return error' do
      expect(token.error).to eq('test')
    end

    it 'should return error_description' do
      expect(token.error_description).to eq('test description')
    end
  end

  describe '#expired?' do
    context 'when expired' do
      let(:token) { Doconomy::Api::Token.new(expires_in: -180) }

      it 'should return true' do
        expect(token.expired?).to eq(true)
      end
    end

    context 'when active' do
      let(:token) { Doconomy::Api::Token.new(expires_in: 180) }

      it 'should return false' do
        expect(token.expired?).to eq(false)
      end
    end
  end

  describe '#error?' do
    context 'with the error' do
      let(:token) { Doconomy::Api::Token.new(error: 'test error') }

      it 'should return true' do
        expect(token.error?).to eq(true)
      end
    end

    context 'without the error' do
      let(:token) { Doconomy::Api::Token.new(error: nil) }

      it 'should return false' do
        expect(token.error?).to eq(false)
      end
    end
  end

  describe '.create' do
    let(:token) { Doconomy::Api::Token.create }

    it 'should create a token' do
      VCR.use_cassette('it_should_create_a_token') do
        expect(token.access_token).to be_present
        expect(token.expires_in).to eq(180)
        expect(token.token_type).to eq('Bearer')
        expect(token.scope).to eq(scope.join(' '))
        expect(token.expired?).to eq(false)
      end
    end
  end
end
