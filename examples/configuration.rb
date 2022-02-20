Dotenv.load('.env')

Doconomy::Api.configuration do |configuration|
  configuration.url = 'https://doconomy-api-sandbox.crosskey.io'
  configuration.client_id = ENV.fetch('CLIENT_ID')
  configuration.api_key = ENV.fetch('X_API_KEY')
  configuration.digital_signature_private_key = ENV.fetch('DIGITAL_SIGNATURE_PRIVATE_KEY')
  configuration.digital_signature_certificate_serial_number = ENV.fetch('DIGITAL_SIGNATURE_CERTIFICATE_SERIAL_NUMBER')
  configuration.digital_signature_certificate = ENV.fetch('DIGITAL_SIGNATURE_CERTIFICATE')
  configuration.pem = File.read(ENV.fetch('PEM_FILE'))
  configuration.scope = 'urn:aland-index:calculations,urn:aland-index:calculations:water-use'
end
