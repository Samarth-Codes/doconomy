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
        if attributes[:carbon_social_cost]
          @carbon_social_cost = OpenStruct.new(attributes[:carbon_social_cost])
        end
        @water_use_in_cubic_meters = attributes[:water_use_in_cubic_meters]
        @water_use_in_gallons = attributes[:water_use_in_gallons]
        if attributes[:water_use_social_cost]
          @water_use_social_cost = OpenStruct.new(attributes[:water_use_social_cost])
        end
      end

      class << self
        # Create the calculations
        #
        # @return [Array<Doconomy::Api::Calculation>]
        #
        def create(payload = {})
          payload.deep_transform_keys! do |key|
            items = key.to_s.camelize.split('')
            items[0].downcase!
            items.join
          end
          response = client.post("/aland-index/#{Doconomy::Api.configuration.api_version}/calculations", payload)
          response[:transaction_footprints].map { |attributes| new(attributes) }
        end
      end
    end
  end
end
