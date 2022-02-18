# frozen_string_literal: true

module Doconomy
  module Api
    class Error < Base
      attr_accessor :source, :reason_code, :description

      def initialize(attributes = {})
        @attributes = attributes.deep_symbolize_keys
        @source = attributes[:source]
        @reason_code = attributes[:reason_code] || attributes[:reasonCode]
        @description = attributes[:description]
      end
    end
  end
end
