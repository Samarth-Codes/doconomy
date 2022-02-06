# frozen_string_literal: true

RSpec.describe Doconomy::Api::MerchantCategory do
  let(:merchant_category) { Doconomy::Api::MerchantCategory.new(code: '4358') }

  describe '#initialize' do
    it 'should return code' do
      expect(merchant_category.code).to eq('4358')
    end

    it 'should return attributes' do
      expect(merchant_category.attributes).to eq({ code: '4358' })
    end
  end

  describe '#all' do
    let(:merchant_categories) { Doconomy::Api::MerchantCategory.all }

    it 'should get all merchant categories' do
      VCR.use_cassette('it_should_get_all_merchant_categories') do
        expect(merchant_categories.size).to eq(1428)
        expect(merchant_categories[0].code).to eq('3860')
        expect(merchant_categories[100].code).to eq('5819')
        expect(merchant_categories[128].code).to eq('3409')
        expect(merchant_categories[256].code).to eq('3695')
        expect(merchant_categories[512].code).to eq('3079')
        expect(merchant_categories[1024].code).to eq('5765')
        expect(merchant_categories[1427].code).to eq('3849')
      end
    end
  end
end
