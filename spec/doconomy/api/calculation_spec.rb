# frozen_string_literal: true

RSpec.describe Doconomy::Api::Calculation, type: :sandbox do
  describe '#initialize' do
    let(:transactions) do
      [
        { reference: 'ref1', mcc: 5421, amount: { value: 123.1, currency: 'USD'} },
        { reference: 'ref2', mcc: 5621, amount: { value: 190.1, currency: 'PLN' } },
        { reference: 'ref3', mcc: 5621, amount: { value: 190.1, currency: 'PLN' } }
      ]
    end
    let(:calculation) { Doconomy::Api::Calculation.new(transactions: transactions) }

    it 'should return reference' do
      expect(calculation.transactions.size).to eq(3)
    end
  end

  describe '.create' do
    let(:transactions_attributes) do
      [
        { reference: 'transaction-1', mcc: 4899, amount: { value: 100.10, currency: 'USD' } },
        { reference: 'transaction-2', mcc: 4899, amount: { value: 10.10, currency: 'EUR' } },
        { reference: 'transaction-3', mcc: 5735, amount: { value: 50.20, currency: 'CHF' } }
      ]
    end

    let(:payload) { { cardTransactions: transactions_attributes } }
    let(:calculation) { Doconomy::Api::Calculation.create(payload) }

    let(:transaction) { calculation.transactions }

    it 'should create a calculation' do
      VCR.use_cassette('it_should_create_a_calculation') do
        # transaction-1
        expect(transaction[0].reference).to eq('transaction-1')
        expect(transaction[0].category_id).to eq(30)
        expect(transaction[0].carbon_emission_in_grams).to eq(46.18)
        expect(transaction[0].carbon_emission_in_ounces).to eq(1.63)
        expect(transaction[0].carbon_social_cost.value).to eq(14.91)
        expect(transaction[0].carbon_social_cost.currency).to eq('USD')
        expect(transaction[0].water_use_in_cubic_meters).to eq(54.59)
        expect(transaction[0].water_use_in_gallons).to eq(14420.93)
        expect(transaction[0].water_use_social_cost.value).to eq(24.92)
        expect(transaction[0].water_use_social_cost.currency).to eq('USD')
        # transaction-2
        expect(transaction[1].reference).to eq('transaction-2')
        expect(transaction[1].category_id).to eq(30)
        expect(transaction[1].carbon_emission_in_grams).to eq(5.54)
        expect(transaction[1].carbon_emission_in_ounces).to eq(0.2)
        expect(transaction[1].carbon_social_cost.value).to eq(1.5)
        expect(transaction[1].carbon_social_cost.currency).to eq('EUR')
        expect(transaction[1].water_use_in_cubic_meters).to eq(6.55)
        expect(transaction[1].water_use_in_gallons).to eq(1731.59)
        expect(transaction[1].water_use_social_cost.value).to eq(2.51)
        expect(transaction[1].water_use_social_cost.currency).to eq('EUR')
        # transaction-3
        expect(transaction[2].reference).to eq('transaction-3')
        expect(transaction[2].category_id).to eq(24)
        expect(transaction[2].carbon_emission_in_grams).to eq(25.21)
        expect(transaction[2].carbon_emission_in_ounces).to eq(0.89)
        expect(transaction[2].carbon_social_cost.value).to eq(7.9)
        expect(transaction[2].carbon_social_cost.currency).to eq('CHF')
        expect(transaction[2].water_use_in_cubic_meters).to eq(29.73)
        expect(transaction[2].water_use_in_gallons).to eq(7853.51)
        expect(transaction[2].water_use_social_cost.value).to eq(12.92)
        expect(transaction[2].water_use_social_cost.currency).to eq('CHF')
      end
    end
  end
end
