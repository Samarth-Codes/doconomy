# frozen_string_literal: true

RSpec.describe Doconomy::Api::Base do
  describe '#client' do
    it 'should return client object' do
      expect(Doconomy::Api::Base.client.class).to eq(Doconomy::Api::Client)
    end
  end

  describe '#errors' do
    let(:base) { Doconomy::Api::Base.new }

    before do
      base.attributes = { errors: [
        { source: 'Aland Index', reasonCode: 'BAD_REQUEST', description: 'cardTransactions[0].reference must be a string' }
      ] }
    end

    it 'should return' do
      expect(base.errors.size).to eq(1)
      expect(base.errors[0].source).to eq('Aland Index')
      expect(base.errors[0].reason_code).to eq('BAD_REQUEST')
      expect(base.errors[0].description).to eq('cardTransactions[0].reference must be a string')
    end
  end
end
