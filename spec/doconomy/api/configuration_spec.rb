# frozen_string_literal: true

RSpec.describe Doconomy::Api::Configuration do
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
