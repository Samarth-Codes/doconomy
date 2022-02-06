# frozen_string_literal: true

module Doconomy
  module Api
    class Calculation < Base
      attr_accessor :reference,
                    :category_id,
                    :carbon_emission_in_grams,
                    :carbon_emission_in_ounces,
                    :carbon_social_cost,
                    :water_use_in_cubic_meters,
                    :water_use_in_gallons,
                    :water_use_social_cost

      def initialize(attributes = {})
        @attributes = attributes
        @reference = attributes[:reference]
        @category_id = attributes[:category_id]
        @carbon_emission_in_grams = attributes[:carbon_emission_in_grams]
        @carbon_emission_in_ounces = attributes[:carbon_emission_in_ounces]
        @carbon_social_cost = OpenStruct.new(attributes[:carbon_social_cost]) if attributes[:carbon_social_cost]
        @water_use_in_cubic_meters = attributes[:water_use_in_cubic_meters]
        @water_use_in_gallons = attributes[:water_use_in_gallons]
        @water_use_social_cost = OpenStruct.new(attributes[:water_use_social_cost]) if attributes[:water_use_social_cost]
      end

      class << self
        # Create the calculations
        #
        # @option payload [Hash]   ({})   Payload
        # @option headers [Hash]   ({ 'Content-Type' => 'application/json' }) Custom headers
        #
        # @return [Array<Doconomy::Api::Calculation>]
        #
        def create(payload = {})
          response = client.post("/aland-index/#{Doconomy::Api.configuration.api_version}/calculations", payload.to_json)
          response[:transaction_footprints].map { |attributes| new(attributes) }
        end
      end
    end
  end
end
