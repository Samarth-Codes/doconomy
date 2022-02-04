# frozen_string_literal: true

RSpec.describe Doconomy::Api do
  describe '#configuration' do
    let(:scope) { 'urn:aland-index:calculations,urn:aland-index:calculations:water-use' }

    it 'should return default configuration' do
      expect(Doconomy::Api.configuration.environment).to eq(:production)
      expect(Doconomy::Api.configuration.api_version).to eq(Doconomy::Api::VERSION)
      expect(Doconomy::Api.configuration.scope).to eq(scope)
      expect(Doconomy::Api.configuration.pem_password).to eq(nil)
    end
  end
end
