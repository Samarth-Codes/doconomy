# frozen_string_literal: true

RSpec.describe Doconomy::Api::Currency do
  let(:currency) { Doconomy::Api::Currency.new(code: 'CHF') }

  it 'should return code' do
    expect(currency.code).to eq('CHF')
  end

  it 'should return attributes' do
    expect(currency.attributes).to eq({ code: 'CHF' })
  end
end
