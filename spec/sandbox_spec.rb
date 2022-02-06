# frozen_string_literal: true

RSpec.shared_context 'Sandbox' do
  before do
    Doconomy::Api.configuration do |configuration|
      configuration.environment = :sandbox
      configuration.scope = ENV['SCOPE']
      configuration.api_key = ENV['X_API_KEY']
      configuration.client_id = ENV['CLIENT_ID']
      configuration.pem = File.read(ENV['PEM_FILE'])
      configuration.digital_signature_private_key = ENV['DIGITAL_SIGNATURE_PRIVATE_KEY']
      configuration.digital_signature_certificate = ENV['DIGITAL_SIGNATURE_CERTIFICATE']
      configuration.digital_signature_certificate_serial_number = ENV['DIGITAL_SIGNATURE_CERTIFICATE_SERIAL_NUMBER']
    end
  end
end

RSpec.configure do |config|
  config.include_context 'Sandbox', type: :sandbox
end
