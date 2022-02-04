# frozen_string_literal: true

module Doconomy
  module Api
    class MerchantCategory < Base
      attr_accessor :code

      def initialize(attributes = {})
        @attributes = attributes
        @code = attributes[:code]
      end

      class << self
        # Returns all merchant categories
        #
        # @return [Array<Doconomy::Api::MerchantCategory>]
        #
        def all
          response = client.get("/aland-index/#{Doconomy::Api.configuration.api_version}/merchant-categories")
          response[:merchant_categories].map { |attributes| new(attributes) }
        end
      end
    end
  end
end
