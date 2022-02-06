# frozen_string_literal: true

RSpec.describe Doconomy::Api::Configuration do
  describe '#initialize' do
    let(:attributes) do
      {
        url: 'https://server.test',
        environment: :production,
        api_key: '32084-234382-3248823-2344',
        api_version: 'v2.1',
        client_id: '234234-234234-23432-324',
        scope: 'urn:aland-index:calculations,urn:aland-index:calculations:water-use',
        digital_signature_private_key: 'private-key',
        digital_signature_certificate_serial_number: 'serial-number',
        digital_signature_certificate: 'certificate',
        pem: 'valid-pem',
        pem_password: 'valid-pem-password'
      }
    end
    let(:configuration) { Doconomy::Api::Configuration.new(attributes) }

    it 'should return url' do
      expect(configuration.url).to eq('https://server.test')
    end

    it 'should return environment' do
      expect(configuration.environment).to eq(:production)
    end

    it 'should return api_key' do
      expect(configuration.api_key).to eq('32084-234382-3248823-2344')
    end

    it 'should return api_version' do
      expect(configuration.api_version).to eq('v2.1')
    end

    it 'should return client_id' do
      expect(configuration.client_id).to eq('234234-234234-23432-324')
    end

    it 'should return scope' do
      expect(configuration.scope).to eq('urn:aland-index:calculations,urn:aland-index:calculations:water-use')
    end

    it 'should return digital_signature_private_key' do
      expect(configuration.digital_signature_private_key).to eq('private-key')
    end

    it 'should return digital_signature_certificate_serial_number' do
      expect(configuration.digital_signature_certificate_serial_number).to eq('serial-number')
    end

    it 'should return digital_signature_certificate' do
      expect(configuration.digital_signature_certificate).to eq('certificate')
    end

    it 'should return pem' do
      expect(configuration.pem).to eq('valid-pem')
    end

    it 'should return pem_password' do
      expect(configuration.pem_password).to eq('valid-pem-password')
    end
  end

  describe '#scope' do
    context 'for a string scope' do
      let(:configuration) { Doconomy::Api::Configuration.new(scope: 'scope1,scope2') }

      it 'should return a scope as a string' do
        expect(configuration.scope).to eq('scope1,scope2')
      end
    end

    context 'for an array scope' do
      let(:configuration) { Doconomy::Api::Configuration.new(scope: %w(scope1 scope2)) }

      it 'should return a scope as a string' do
        expect(configuration.scope).to eq('scope1,scope2')
      end
    end
  end

  describe '#url' do
    context 'for production environment' do
      let(:configuration) { Doconomy::Api::Configuration.new(url: nil, environment: :production) }

      it 'should return production url' do
        expect(configuration.url).to eq(Doconomy::Api::Configuration::PRODUCTION_URL)
      end
    end

    context 'for sandbox environment' do
      let(:configuration) { Doconomy::Api::Configuration.new(url: nil, environment: :sandbox) }

      it 'should return sandbox url' do
        expect(configuration.url).to eq(Doconomy::Api::Configuration::SANDBOX_URL)
      end
    end

    context 'custom url' do
      let(:configuration) { Doconomy::Api::Configuration.new(url: 'http://custom-url.test', environment: :production) }

      it 'should return production url' do
        expect(configuration.url).to eq('http://custom-url.test')
      end
    end
  end

  describe '#production?' do
    let(:configuration) { Doconomy::Api::Configuration.new(environment: :production) }

    it 'should return true' do
      expect(configuration.production?).to eq(true)
    end
  end

  describe '#sandbox?' do
    let(:configuration) { Doconomy::Api::Configuration.new(environment: :sandbox) }

    it 'should return true' do
      expect(configuration.sandbox?).to eq(true)
    end
  end

  describe '.default' do
    let(:default_configuration) { Doconomy::Api::Configuration.default }

    it 'should return default configuration object' do
      expect(default_configuration.attributes).to eq(Doconomy::Api::Configuration.default_options)
    end
  end

  describe '.default_options' do
    let(:options) { Doconomy::Api::Configuration.default_options }

    it 'should return default options' do
      expect(options).to eq({
        environment: :production,
        api_version: Doconomy::Api::VERSION,
        scope: Doconomy::Api::Configuration::SCOPE,
        pem_password: nil
      })
    end
  end
end
