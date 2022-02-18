# frozen_string_literal: true

module Doconomy
  module Api
    class Base
      attr_accessor :attributes

      def errors
        @errors = attributes[:errors].map do |attrs|
          attrs.is_a?(Hash) ? Doconomy::Api::Error.new(attrs) : attrs
        end if attributes[:errors]
      end

      class << self
        def client
          @client ||= Doconomy::Api::Client.new
        end
      end
    end
  end
end
