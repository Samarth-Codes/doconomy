# frozen_string_literal: true

module Doconomy
  module Api
    class Language < Base
      attr_accessor :code

      def initialize(attributes = {})
        @attributes = attributes
        @code = attributes[:code]
      end

      class << self
        # Returns all languages
        #
        # @return [Array<Doconomy::Api::Language>]
        #
        def all
          response = client.get("/aland-index/#{Doconomy::Api.configuration.api_version}/languages")
          response[:languages].map { |attributes| new(attributes) }
        end
      end
    end
  end
end
