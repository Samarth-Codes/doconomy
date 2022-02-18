# frozen_string_literal: true

RSpec.describe Doconomy::Api::Transaction do
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
  let(:transaction) { Doconomy::Api::Transaction.new(attributes) }

  describe '#initialize' do
    it 'should return reference' do
      expect(transaction.reference).to eq('123-1234-12345')
    end

    it 'should return category_id' do
      expect(transaction.category_id).to eq('4589')
    end

    it 'should return carbon_emission_in_grams' do
      expect(transaction.carbon_emission_in_grams).to eq('10.2')
    end

    it 'should return carbon_emission_in_ounces' do
      expect(transaction.carbon_emission_in_ounces).to eq('10.2')
    end

    it 'should return carbon_social_cost.value' do
      expect(transaction.carbon_social_cost.value).to eq('10.2')
    end

    it 'should return carbon_social_cost.currency' do
      expect(transaction.carbon_social_cost.currency).to eq('CHF')
    end

    it 'should return water_use_in_cubic_meters' do
      expect(transaction.water_use_in_cubic_meters).to eq('10.2')
    end

    it 'should return water_use_in_gallons' do
      expect(transaction.water_use_in_gallons).to eq('10.2')
    end

    it 'should return water_use_social_cost.value' do
      expect(transaction.water_use_social_cost.value).to eq('10.2')
    end

    it 'should return water_use_social_cost.currency' do
      expect(transaction.water_use_social_cost.currency).to eq('PLN')
    end

    it 'should return attributes' do
      expect(transaction.attributes).to eq(attributes)
    end
  end
end
