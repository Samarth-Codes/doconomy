require 'doconomy'
require 'dotenv'
require './configuration.rb'

transactions = [
  { reference: 'id:1', mcc: 4899, amount: { value: 150.0, currency: 'USD' } },
  { reference: 'id:2', mcc: 4899, amount: { value: 140.0, currency: 'CHF' } },
  { reference: 'id:3', mcc: 4899, amount: { value: 130.0, currency: 'EUR' } },
  { reference: 'id:4', mcc: 5735, amount: { value: 120.0, currency: 'USD' } },
  { reference: 'id:5', mcc: 5735, amount: { value: 110.0, currency: 'CHF' } }
]
payload = { cardTransactions: transactions }
calculation = Doconomy::Api::Calculation.create(payload)

calculation.transactions.each do |transaction|
  puts transaction.reference
  puts transaction.category_id
  puts transaction.mcc
  puts transaction.amount.value
  puts transaction.amount.currency
  puts transaction.carbon_emission_in_grams
  puts transaction.carbon_emission_in_ounces
  unless transaction.carbon_social_cost.nil?
    puts transaction.carbon_social_cost.value
    puts transaction.carbon_social_cost.currency
  end
  puts transaction.water_use_in_cubic_meters
  puts transaction.water_use_in_gallons
  unless transaction.water_use_social_cost.nil?
    puts transaction.water_use_social_cost.value
    puts transaction.water_use_social_cost.currency
  end
  puts '----'
end
