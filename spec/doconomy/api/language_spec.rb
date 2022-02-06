# frozen_string_literal: true

RSpec.describe Doconomy::Api::Language do
  let(:language) { Doconomy::Api::Language.new(code: 'PL') }

  describe '#initialize' do
    it 'should return code' do
      expect(language.code).to eq('PL')
    end

    it 'should return attributes' do
      expect(language.attributes).to eq({ code: 'PL' })
    end
  end

  describe '#all' do
    let(:languages) { Doconomy::Api::Language.all }

    it 'should get all languages' do
      VCR.use_cassette('it_should_get_all_languages') do
        expect(languages.size).to eq(8)
        expect(languages[0].code).to eq('de')
        expect(languages[1].code).to eq('en')
        expect(languages[2].code).to eq('es')
        expect(languages[3].code).to eq('fi')
        expect(languages[4].code).to eq('fr')
        expect(languages[5].code).to eq('it')
        expect(languages[6].code).to eq('nl')
        expect(languages[7].code).to eq('sv')
      end
    end
  end
end
