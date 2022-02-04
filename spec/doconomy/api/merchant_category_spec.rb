# frozen_string_literal: true

RSpec.describe Doconomy::Api::MerchantCategory do
  let(:merchant_category) { Doconomy::Api::MerchantCategory.new(code: '4358') }

  it 'should return code' do
    expect(merchant_category.code).to eq('4358')
  end

  it 'should return attributes' do
    expect(merchant_category.attributes).to eq({ code: '4358' })
  end
end
