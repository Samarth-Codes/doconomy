# frozen_string_literal: true

RSpec.describe Doconomy::Api::Calculation do
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
