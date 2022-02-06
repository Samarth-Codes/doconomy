# frozen_string_literal: true

RSpec.describe Doconomy::Api::Calculation, type: :sandbox do
  let(:attributes) do
    {
      reference: '123-1234-12345',
      category_id: '4589',
      carbon_emission_in_grams: '10.2',
      carbon_emission_in_ounces: '10.2',
      carbon_social_cost: { value: '10.2', currency: 'CHF' },
      water_use_in_cubic_meters: '10.2',
      water_use_in_gallons: '10.2',
      water_use_social_cost: { value: '10.2', currency: 'PLN' }
    }
  end
  let(:calculation) { Doconomy::Api::Calculation.new(attributes) }

  describe '#initialize' do
    it 'should return reference' do
      expect(calculation.reference).to eq('123-1234-12345')
    end

    it 'should return category_id' do
      expect(calculation.category_id).to eq('4589')
    end

    it 'should return carbon_emission_in_grams' do
      expect(calculation.carbon_emission_in_grams).to eq('10.2')
    end

    it 'should return carbon_emission_in_ounces' do
      expect(calculation.carbon_emission_in_ounces).to eq('10.2')
    end

    it 'should return carbon_social_cost.value' do
      expect(calculation.carbon_social_cost.value).to eq('10.2')
    end

    it 'should return carbon_social_cost.currency' do
      expect(calculation.carbon_social_cost.currency).to eq('CHF')
    end

    it 'should return water_use_in_cubic_meters' do
      expect(calculation.water_use_in_cubic_meters).to eq('10.2')
    end

    it 'should return water_use_in_gallons' do
      expect(calculation.water_use_in_gallons).to eq('10.2')
    end

    it 'should return water_use_social_cost.value' do
      expect(calculation.water_use_social_cost.value).to eq('10.2')
    end

    it 'should return water_use_social_cost.currency' do
      expect(calculation.water_use_social_cost.currency).to eq('PLN')
    end

    it 'should return attributes' do
      expect(calculation.attributes).to eq(attributes)
    end
  end

  describe '.create' do
    let(:transactions) do
      [
        { reference: 'transaction-1', mcc: 4899, amount: { value: 100.10, currency: 'USD' } },
        { reference: 'transaction-2', mcc: 4899, amount: { value: 10.10, currency: 'EUR' } },
        { reference: 'transaction-3', mcc: 5735, amount: { value: 50.20, currency: 'CHF' } }
      ]
    end

    let(:payload) { { cardTransactions: transactions } }
    let(:calculation) { Doconomy::Api::Calculation.create(payload) }

    it 'should create a calculation' do
      VCR.use_cassette('it_should_create_a_calculation') do
        # transaction-1
        expect(calculation[0].reference).to eq('transaction-1')
        expect(calculation[0].category_id).to eq(30)
        expect(calculation[0].carbon_emission_in_grams).to eq(46.18)
        expect(calculation[0].carbon_emission_in_ounces).to eq(1.63)
        expect(calculation[0].carbon_social_cost.value).to eq(14.91)
        expect(calculation[0].carbon_social_cost.currency).to eq('USD')
        expect(calculation[0].water_use_in_cubic_meters).to eq(54.59)
        expect(calculation[0].water_use_in_gallons).to eq(14420.93)
        expect(calculation[0].water_use_social_cost.value).to eq(24.92)
        expect(calculation[0].water_use_social_cost.currency).to eq('USD')
        # transaction-2
        expect(calculation[1].reference).to eq('transaction-2')
        expect(calculation[1].category_id).to eq(30)
        expect(calculation[1].carbon_emission_in_grams).to eq(5.54)
        expect(calculation[1].carbon_emission_in_ounces).to eq(0.2)
        expect(calculation[1].carbon_social_cost.value).to eq(1.5)
        expect(calculation[1].carbon_social_cost.currency).to eq('EUR')
        expect(calculation[1].water_use_in_cubic_meters).to eq(6.55)
        expect(calculation[1].water_use_in_gallons).to eq(1731.59)
        expect(calculation[1].water_use_social_cost.value).to eq(2.51)
        expect(calculation[1].water_use_social_cost.currency).to eq('EUR')
        # transaction-3
        expect(calculation[2].reference).to eq('transaction-3')
        expect(calculation[2].category_id).to eq(24)
        expect(calculation[2].carbon_emission_in_grams).to eq(25.21)
        expect(calculation[2].carbon_emission_in_ounces).to eq(0.89)
        expect(calculation[2].carbon_social_cost.value).to eq(7.9)
        expect(calculation[2].carbon_social_cost.currency).to eq('CHF')
        expect(calculation[2].water_use_in_cubic_meters).to eq(29.73)
        expect(calculation[2].water_use_in_gallons).to eq(7853.51)
        expect(calculation[2].water_use_social_cost.value).to eq(12.92)
        expect(calculation[2].water_use_social_cost.currency).to eq('CHF')
      end
    end
  end
end
