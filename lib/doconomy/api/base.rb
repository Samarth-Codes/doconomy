# frozen_string_literal: true

module Doconomy
  module Api
    class Base
      attr_accessor :attributes

      class << self
        def client
          @client ||= Doconomy::Api::Client.new
        end
      end
    end
  end
end
