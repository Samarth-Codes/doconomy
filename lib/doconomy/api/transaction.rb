# frozen_string_literal: true

module Doconomy
  module Api
    class Transaction < Base
      attr_accessor :reference,
                    :category_id,
                    :carbon_emission_in_grams,
                    :carbon_emission_in_ounces,
                    :carbon_social_cost,
                    :water_use_in_cubic_meters,
                    :water_use_in_gallons,
                    :water_use_social_cost,
                    :amount,
                    :mcc

      def initialize(attributes = {})
        @attributes = attributes.deep_symbolize_keys
        @reference = @attributes[:reference]
        @category_id = @attributes[:category_id]
        @carbon_emission_in_grams = @attributes[:carbon_emission_in_grams]
        @carbon_emission_in_ounces = @attributes[:carbon_emission_in_ounces]
        @carbon_social_cost = OpenStruct.new(@attributes[:carbon_social_cost]) if @attributes[:carbon_social_cost]
        @water_use_in_cubic_meters = @attributes[:water_use_in_cubic_meters]
        @water_use_in_gallons = @attributes[:water_use_in_gallons]
        @water_use_social_cost = OpenStruct.new(@attributes[:water_use_social_cost]) if @attributes[:water_use_social_cost]
        @amount = OpenStruct.new(@attributes[:amount]) if @attributes[:amount]
        @mcc = @attributes[:mcc]
      end
    end
  end
end
