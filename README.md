[![Gem Version](https://badge.fury.io/rb/doconomy.svg)](https://badge.fury.io/rb/doconomy)
[![License MIT](https://img.shields.io/github/license/lukaszsliwa/doconomy)](https://github.com/lukaszsliwa/doconomy/blob/master/LICENSE)
[![Coverage Status](https://coveralls.io/repos/lukaszsliwa/doconomy/badge.svg)](https://coveralls.io/r/lukaszsliwa/doconomy)

# Doconomy API Ruby Client

Doconomy API Ruby Client

Åland Index is an index for CO2 emission calculations for payments and financial transactions.

## Instalation

Run

```shell
$ gem install doconomy
```

or add new gem to the `Gemfile`

```ruby
gem 'doconomy'
```

and run

```shell
$ bundle install
```

## Generate PEM file

```shell
$ openssl pkcs12 -export -in certificate.pub -inkey certificate.prv -out certificate.p12
$ openssl pkcs12 -in certificate.p12 -nodes -out certificate.pem
```

## Configuration

```ruby
# app/config/initializers/doconomy.rb

Doconomy::Api.configuration do |configuration|
  configuration.environment = :sandbox # or :production
  configuration.api_version = 'v2.1'
  configuration.api_key = ENV['X_API_KEY']
  configuration.client_id = ENV['CLIENT_ID']
  configuration.scope = ENV['SCOPE']
  configuration.digital_signature_private_key = ENV['DIGITAL_SIGNATURE_PRIVATE_KEY']
  configuration.digital_signature_certificate_serial_number = ENV['DIGITAL_SIGNATURE_CERTIFICATE_SERIAL_NUMBER']
  configuration.digital_signature_certificate = ENV['DIGITAL_SIGNATURE_CERTIFICATE']
  configuration.pem = File.read(ENV['PEM_FILE'])
  # configuration.pem_password = nil
end

payload = { cardTransactions: [ ... ] }
Doconomy::Api::Calculation.create(payload)

```

Current token is stored in

```ruby
Doconomy::Api.current_token
```

and it is automatically refreshed base on the `expires_in` attribute.

## Create a token manually

If you would like to create an token manually just call `Doconomy::Api::Token.create()`

```ruby
token = Doconomy::Api::Token.create
puts token.access_token
puts token.expires_at
```

## Create calculations

Calculation requires four attributes: `reference`, `mcc` (merchant category code), `value` and `currency`.

```ruby
transactions = [
  { reference: 1, mcc: 4899, amount: { value: 100.10, currency: 'CHF' } },
  { reference: 2, mcc: 4899, amount: { value: 10.10, currency: 'CHF' } },
  { reference: 3, mcc: 5735, amount: { value: 50.20, currency: 'CHF' } }
]
payload = {
  cardTransactions: transactions
}

transactions = Doconomy::Api::Calculation.create(payload)
transactions.each do |transaction|
  puts transaction.reference
  puts transaction.category_id
  # `carbon_*` attributes are set if scope includes 
  # urn:aland-index:calculations
  puts transaction.carbon_emission_in_grams
  puts transaction.carbon_emission_in_ounces
  puts transaction.carbon_social_cost.value
  puts transaction.carbon_social_cost.currency
  # `water_use_*` attributes are set if scope includes 
  # urn:aland-index:calculations:water-use
  puts transaction.water_use_in_cubic_meters
  puts transaction.water_use_in_gallons
  puts transaction.water_use_social_cost.value
  puts transaction.water_use_social_cost.currency
  puts '----'
end
```

Be sure that the `Doconomy::Api.configuration.scope` is set to the correct scopes.

```ruby
Doconomy::Api.configuration do |config|
  # ...
  config.scope = 'urn:aland-index:calculations,urn:aland-index:calculations:water-use'
  # ...
end
```

## Get all merchant categories

```ruby
merchant_categories = Doconomy::Api::MerchantCategory.all
merchant_categories.each do |merchant_category|
  puts merchant_category.code
end
```

## Get all languages

```ruby
languages = Doconomy::Api::Language.all
languages.each do |language|
  puts language.code
end
```

## Get all currencies

```ruby
currencies = Doconomy::Api::Currency.all
currencies.each do |currency|
  puts currency.code
end
```

## Get all categories

```ruby
categories = Doconomy::Api::Category.all
categories.each do |category|
  puts category.code
end
```

## Get a category

```ruby
Doconomy::Api::Category.find(1).code
```

## Copyright

Copyright (c) 2022 [Łukasz Śliwa](http://lukaszsliwa.com) 

See LICENSE.txt for further details.

