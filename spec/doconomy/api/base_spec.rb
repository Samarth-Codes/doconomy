# frozen_string_literal: true

RSpec.describe Doconomy::Api::Base do
  describe '#client' do
    it 'should return client object' do
      expect(Doconomy::Api::Base.client.class).to eq(Doconomy::Api::Client)
    end
  end
end
