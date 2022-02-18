# frozen_string_literal: true

module Doconomy
  module Api
    class Calculation < Base
      attr_accessor :transactions

      def initialize(attributes = {})
        @attributes = attributes.deep_symbolize_keys
        @transactions = @attributes[:transactions].map do |attrs|
          attrs.is_a?(Hash) ? Transaction.new(attrs) : attrs
        end if @attributes[:transactions]
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
          payload.deep_symbolize_keys!
          response = client.post("/aland-index/#{Doconomy::Api.configuration.api_version}/calculations", payload.to_json)

          transactions_attributes = {}
          payload[:cardTransactions].each do |item|
            transactions_attributes[item[:reference]] = item.symbolize_keys
          end
          response[:transaction_footprints].each do |item|
            transactions_attributes[item[:reference]] ||= {}
            transactions_attributes[item[:reference]].merge!(item.symbolize_keys)
          end

          new(transactions: transactions_attributes.values, errors: response[:errors])
        end
      end
    end
  end
end
