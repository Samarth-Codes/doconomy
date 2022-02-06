# frozen_string_literal: true

module Doconomy
  module Api
    class Client < Base

      # It makes HTTP GET request
      #
      # @param endpoint
      # @param headers      ({ 'Content-Type' => 'application/json' }) Custom headers
      # @param options      ({}) Additional options like `with_authorization'
      #
      # @return [Hash]
      #
      def get(endpoint, headers = { 'Content-Type' => 'application/json' }, options = {})
        request(:get, endpoint, nil, headers, options)
      end

      # It makes HTTP POST request
      #
      # @param endpoint
      # @param headers      ({ 'Content-Type' => 'application/json' }) Custom headers
      # @param options      ({}) Additional options like `with_authorization'
      #
      # @return [Hash]
      #
      def post(endpoint, payload = nil, headers = { 'Content-Type' => 'application/json' }, options = {})
        request(:post, endpoint, payload, headers, options)
      end

      # It makes HTTP PUT request
      #
      # @param endpoint
      # @param headers      ({ 'Content-Type' => 'application/json' }) Custom headers
      # @param options      ({}) Additional options like `with_authorization'
      #
      # @return [Hash]
      #
      def put(endpoint, payload = nil, headers = { 'Content-Type' => 'application/json' }, options = {})
        request(:put, endpoint, payload, headers, options)
      end

      # It makes HTTP DELETE request
      #
      # @param endpoint
      # @param headers      ({ 'Content-Type' => 'application/json' }) Custom headers
      # @param options      ({}) Additional options like `with_authorization'
      #
      # @return [Hash]
      #
      def delete(endpoint, headers = { 'Content-Type' => 'application/json' }, options = {})
        request(:delete, endpoint, nil, headers, options)
      end

      # It makes HTTP HEAD request
      #
      # @param endpoint
      # @param headers      ({ 'Content-Type' => 'application/json' }) Custom headers
      # @param options      ({}) Additional options like `with_authorization'
      #
      # @return [Hash]
      #
      def head(endpoint, headers = { 'Content-Type' => 'application/json' }, options = {})
        request(:head, endpoint, nil, headers, options)
      end

      private

      def request(method, endpoint, payload = nil, headers = {}, options = {})
        if options[:with_authorization].nil? || options[:with_authorization]
          return request_with_authorization(method, endpoint, payload, headers, options)
        end
        request_without_authorization(method, endpoint, payload, headers)
      end

      def request_without_authorization(method, endpoint, payload = nil, headers = {})
        request_params = prepare_request_params(method, endpoint, payload).merge(
          headers: headers_without_authorization.merge(headers)
        )
        request_execute(request_params)
      end

      def request_with_authorization(method, endpoint, payload = nil, headers = {}, options = {})
        request_params = prepare_request_params(method, endpoint, payload).merge(
          headers: headers_with_authorization(options).merge(headers)
        )
        request_execute(request_params)
      end

      def request_execute(params)
        body = RestClient::Request.execute(params).body
        JSON.parse(body).deep_transform_keys { |key| key.to_s.underscore.to_sym }
      end

      def prepare_request_params(method, endpoint, payload = nil)
        {
          method: method,
          url: url_for(endpoint),
          payload: payload,
          ssl_client_cert: ssl_client_cert,
          ssl_client_key: ssl_client_key
        }
      end

      def headers_without_authorization
        {
          'X-API-Key' => Doconomy::Api.configuration.api_key,
          'Content-Type' => 'application/json',
          'digitalSignaturePrivateKey' => Doconomy::Api.configuration.digital_signature_private_key,
          'digitalSignatureCertificateSerialNumber' => Doconomy::Api.configuration.digital_signature_certificate_serial_number,
          'digitalSignatureCertificate' => Doconomy::Api.configuration.digital_signature_certificate
        }
      end

      def headers_with_authorization(options = {})
        bearer_token = if options[:with_authorization].is_a?(String)
          options[:with_authorization]
        else
          Doconomy::Api.current_token.access_token
        end
        headers_without_authorization.merge({
          'Authorization' => "Bearer #{bearer_token}"
        })
      end

      def url_for(endpoint)
        "#{Doconomy::Api.configuration.url}#{endpoint}"
      end

      def ssl_client_cert
        OpenSSL::X509::Certificate.new(Doconomy::Api.configuration.pem)
      end

      def ssl_client_key
        OpenSSL::PKey.read(Doconomy::Api.configuration.pem, Doconomy::Api.configuration.pem_password)
      end
    end
  end
end
