# frozen_string_literal: true

require_relative "beer/version"
require "active_support"
require "faraday"

module Beer
  autoload :Client, "beer/client"
  autoload :Response, "beer/response"
end
