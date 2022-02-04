# frozen_string_literal: true

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string'
require 'rest-client'
require 'ostruct'
require 'openssl'
require 'json'

module Doconomy
  autoload :Api, 'doconomy/api.rb'
end
