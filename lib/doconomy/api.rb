# frozen_string_literal: true

module Doconomy
  module Api
    VERSION = 'v2.1'

    autoload :Base, 'doconomy/api/base.rb'
    autoload :Calculation, 'doconomy/api/calculation.rb'
    autoload :Category, 'doconomy/api/category.rb'
    autoload :Client, 'doconomy/api/client.rb'
    autoload :Configuration, 'doconomy/api/configuration.rb'
    autoload :Currency, 'doconomy/api/currency.rb'
    autoload :Language, 'doconomy/api/language.rb'
    autoload :MerchantCategory, 'doconomy/api/merchant_category.rb'
    autoload :Token, 'doconomy/api/token.rb'

    class << self
      # Configure Doconomy API
      #
      # @return [Doconomy::Api::Configuration]
      #
      def configuration
        @configuration ||= Doconomy::Api::Configuration.default
        yield(@configuration) if block_given?
        @configuration
      end

      # Returns current token object. Refresh automatically if the token has been expired.
      #
      # @return [Doconomy::Api::Token]
      #
      def current_token
        if @current_token.nil? || @current_token.expired?
          @current_token = Doconomy::Api::Token.create
        end
        @current_token
      end
    end
  end
end
