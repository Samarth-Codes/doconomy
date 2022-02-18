# frozen_string_literal: true

module Doconomy
  module Api
    class Currency < Base
      attr_accessor :code

      def initialize(attributes = {})
        @attributes = attributes.deep_symbolize_keys
        @code = @attributes[:code]
      end

      class << self
        # Returns all currencies
        #
        # @return [Array<Doconomy::Api::Currency>]
        #
        def all
          response = client.get("/aland-index/#{Doconomy::Api.configuration.api_version}/currencies")
          response[:currencies].map { |attributes| new(attributes) }
        end
      end
    end
  end
end
