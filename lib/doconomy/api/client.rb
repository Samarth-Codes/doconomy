# frozen_string_literal: true

module Doconomy
  module Api
    class Client < Base
      def get(endpoint, headers = {}, options = {})
        request(:get, endpoint, headers, options)
      end

      def post(endpoint, payload = nil, headers = {}, options = {})
        request(:post, endpoint, payload, headers, options)
      end

      def put(endpoint, payload = nil, headers = {}, options = {})
        request(:put, endpoint, payload, headers, options)
      end

      def delete(endpoint, headers = {}, options = {})
        request(:delete, endpoint, headers, options)
      end

      def head(endpoint, headers = {}, options = {})
        request(:head, endpoint, headers, options)
      end

      private

      def request(method, endpoint, payload = nil, headers = {}, options = {})
        if options[:with_authorization].nil? || options[:with_authorization]
          return request_with_authorization(method, endpoint, payload, headers)
        end
        request_without_authorization(method, endpoint, payload, headers)
      end

      def request_without_authorization(method, endpoint, payload = nil, headers = {})
        request_hash = {
          method: method,
          url: url_for(endpoint),
          payload: payload,
          headers: headers_without_authorization.merge(headers),
          ssl_client_cert: ssl_client_cert,
          ssl_client_key: ssl_client_key
        }
        body = RestClient::Request.execute(request_hash).body
        JSON.parse(body).deep_transform_keys { |key| key.to_s.downcase.to_sym }
      end

      def request_with_authorization(method, endpoint, payload = nil, headers = {})
        request_hash = {
          method: method,
          url: url_for(endpoint),
          payload: payload.to_json,
          headers: headers_with_authorization.merge(headers),
          ssl_client_cert: ssl_client_cert,
          ssl_client_key: ssl_client_key
        }
        body = RestClient::Request.execute(request_hash).body
        JSON.parse(body).deep_transform_keys { |key| key.to_s.underscore.to_sym }
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

      def headers_with_authorization
        headers_without_authorization.merge({
          'Authorization' => "Bearer #{Doconomy::Api.current_token.access_token}"
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
