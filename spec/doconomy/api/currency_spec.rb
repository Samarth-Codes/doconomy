# frozen_string_literal: true

RSpec.describe Doconomy::Api::Currency do
  let(:currency) { Doconomy::Api::Currency.new(code: 'CHF') }

  describe '#initialize' do
    it 'should return code' do
      expect(currency.code).to eq('CHF')
    end

    it 'should return attributes' do
      expect(currency.attributes).to eq({ code: 'CHF' })
    end
  end

  describe '#all' do
    let(:currencies) { Doconomy::Api::Currency.all }

    it 'should get all currencies' do
      VCR.use_cassette('it_should_get_all_currencies') do
        expect(currencies.size).to eq(12)
        expect(currencies[0].code).to eq('AUD')
        expect(currencies[1].code).to eq('CAD')
        expect(currencies[2].code).to eq('CHF')
        expect(currencies[3].code).to eq('DKK')
        expect(currencies[4].code).to eq('EUR')
        expect(currencies[5].code).to eq('GBP')
        expect(currencies[6].code).to eq('NOK')
        expect(currencies[7].code).to eq('NZD')
        expect(currencies[8].code).to eq('PLN')
        expect(currencies[9].code).to eq('RUB')
        expect(currencies[10].code).to eq('SEK')
        expect(currencies[11].code).to eq('USD')
      end
    end
  end
end
