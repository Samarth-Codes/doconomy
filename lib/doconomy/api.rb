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
      # @param [Doconomy::Api::Configuration] (default)
      #
      # @return [Doconomy::Api::Configuration]
      #
      def configuration(configuration = Doconomy::Api::Configuration.default)
        @configuration ||= configuration
        yield(@configuration) if block_given?
        @configuration
      end

      # Sets new configuration Doconomy API
      #
      # @param [Doconomy::Api::Configuration]
      #
      # @return [Doconomy::Api::Configuration]
      #
      def configuration=(configuration)
        @configuration = configuration
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

      # Sets current token object.
      #
      # @return [Doconomy::Api::Token]
      #
      def current_token=(token)
        @current_token = token
      end
    end
  end
end
