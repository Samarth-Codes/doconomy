# frozen_string_literal: true

module Doconomy
  module Api
    class Token < Base
      attr_reader :access_token, :scope, :token_type, :expires_in, :expires_at, :error_description, :error

      def initialize(attributes = {})
        @attributes = attributes
        @access_token = attributes[:access_token]
        @scope = attributes[:scope]
        @token_type = attributes[:token_type]
        @expires_in = attributes[:expires_in]
        @expires_at = Time.current + @expires_in.to_i if @expires_in
        @error_description = attributes[:error_description]
        @error = attributes[:error]
      end

      # Returns true if token has been expired
      #
      # @return [Boolean]
      #
      def expired?
        !expires_at.nil? && expires_at <= Time.current
      end

      # Returns true if token has error
      #
      # @return [Boolean]
      #
      def error?
        !error.nil?
      end

      class << self
        # Creates new token
        #
        # @return [Doconomy::Api::Token]
        #
        def create
          scope = Doconomy::Api.configuration.scope
          scope = scope.join(',') if scope.is_a?(Array)
          payload = {
            grant_type: 'client_credentials',
            scope: scope,
            client_id: Doconomy::Api.configuration.client_id
          }
          new(client.post('/oidc/v1.0/token', payload, { 'Content-Type' => 'application/x-www-form-urlencoded' }, with_authorization: false))
        end
      end
    end
  end
end
