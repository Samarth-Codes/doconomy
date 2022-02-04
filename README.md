# Doconomy API v2.1.3 Ruby Client

Doconomy API Ruby Client v2.1.3

Åland Index is an index for CO2 emission calculations for payments and financial transactions.

## Instalation

```ruby
gem install doconomy
```

## Configuration

```ruby
  Doconomy::Api.configuration do |configuration|
    configuration.environment = :sandbox
    configuration.api_version = 'v2.1'
    configuration.api_key = ENV['X_API_KEY']
    configuration.client_id = ENV['CLIENT_ID']
    configuration.digital_signature_private_key = ENV['DIGITAL_SIGNATURE_PRIVATE_KEY']
    configuration.digital_signature_certificate_serial_number = ENV['DIGITAL_SIGNATURE_CERTIFICATE_SERIAL_NUMBER']
    configuration.digital_signature_certificate = ENV['DIGITAL_SIGNATURE_CERTIFICATE']
    configuration.pem = File.read(ENV['PEM_FILE'])
  end
 
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

```ruby
  transactions = [
    { reference: 1, mcc: 4899, amount: { value: 100.10, currency: 'CHF' } },
    { reference: 2, mcc: 4899, amount: { value: 10.10, currency: 'CHF' } },
    { reference: 3, mcc: 5735, amount: { value: 50.20, currency: 'CHF' } }
  ]
  payload = {
    card_transactions: transactions
  }

  transactions = Doconomy::Api::Calculation.create(payload)
  transactions.each do |transaction|
    puts transaction.reference
    puts transaction.category_id
    puts transaction.carbon_emission_in_grams
    puts transaction.carbon_emission_in_ounces
    puts transaction.carbon_social_cost.value
    puts transaction.carbon_social_cost.currency
    puts transaction.water_use_in_cubic_meters
    puts transaction.water_use_in_gallons
    puts transaction.water_use_social_cost.value
    puts transaction.water_use_social_cost.currency
    puts '----'
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

Copyright (c) 2022 [Łukasz Śliwa](http://lukaszsliwa.com). 

See LICENSE.txt for further details.

