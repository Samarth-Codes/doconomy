# frozen_string_literal: true

module Doconomy
  module Api
    class Category < Base
      attr_accessor :id, :main_category, :sub_category

      def initialize(attributes = {})
        @attributes = attributes.deep_symbolize_keys
        @id = @attributes[:id]
        @main_category = OpenStruct.new(@attributes[:main_category]) if @attributes[:main_category]
        @sub_category = OpenStruct.new(@attributes[:sub_category]) if @attributes[:sub_category]
      end

      class << self
        # Get all categories
        #
        # @return [Array<Doconomy::Api::Category>]
        #
        def all
          response = client.get("/aland-index/#{Doconomy::Api.configuration.api_version}/categories")
          response[:categories].map { |attributes| new(attributes) }
        end

        # Get a category with the given ID
        #
        # @return [Doconomy::Api::Category]
        #
        def find(id)
          new(client.get("/aland-index/#{Doconomy::Api.configuration.api_version}/categories/#{id}"))
        end
      end
    end
  end
end
