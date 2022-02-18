# frozen_string_literal: true

module Doconomy
  module Api
    class Configuration < Base
      PRODUCTION_URL = 'https://services.doconomy.com'
      SANDBOX_URL = 'https://services-sandbox.doconomy.com'
      SCOPE = 'urn:aland-index:calculations,urn:aland-index:calculations:water-use'

      attr_accessor :url,
                    :environment,
                    :api_key,
                    :api_version,
                    :client_id,
                    :client_secret,
                    :scope,
                    :digital_signature_private_key,
                    :digital_signature_certificate_serial_number,
                    :digital_signature_certificate,
                    :pem,
                    :pem_password

      def initialize(attributes = {})
        @attributes = attributes.deep_symbolize_keys
        @url = @attributes[:url]
        @environment = @attributes[:environment]
        @api_key = @attributes[:api_key]
        @api_version = @attributes[:api_version]
        @client_id = @attributes[:client_id]
        @client_secret = @attributes[:client_secret]
        @scope = @attributes[:scope]
        @digital_signature_private_key = @attributes[:digital_signature_private_key]
        @digital_signature_certificate_serial_number = @attributes[:digital_signature_certificate_serial_number]
        @digital_signature_certificate = @attributes[:digital_signature_certificate]
        @pem = @attributes[:pem]
        @pem_password = @attributes[:pem_password]
      end

      # Return the server URL
      #
      # @return [String]
      #
      def url
        return @url if @url

        production? ? PRODUCTION_URL : SANDBOX_URL
      end

      # Return the scope
      #
      # @return [String]
      #
      def scope
        @scope.is_a?(Array) ? @scope.join(',') : @scope
      end

      # Returns true if the configuration environment is `production'
      #
      # @return [Boolean]
      #
      def production?
        self.environment.downcase.to_sym == :production
      end

      # Returns true if the configuration environment is `sandbox'
      #
      # @return [Boolean]
      #
      def sandbox?
        self.environment.downcase.to_sym == :sandbox
      end

      class << self
        # Returns a default configuration instance
        #
        # @return [Doconomy::Api::Configuration]
        def default
          new(default_options)
        end

        # Default attributes for Doconomy::Api::Configuration instance
        #
        # @return [Hash]
        def default_options
          {
            environment: :production,
            api_version: Doconomy::Api::VERSION,
            scope: Doconomy::Api::Configuration::SCOPE,
            pem_password: nil
          }
        end
      end
    end
  end
end
