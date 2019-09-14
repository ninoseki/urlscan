# frozen_string_literal: true

require "forwardable"

module UrlScan
  class API
    extend Forwardable

    attr_reader :pro

    def initialize(key = ENV["URLSCAN_API_KEY"])
      @community = Clients::Community.new(key)
      @pro = Clients::Pro.new(key)
    end

    def_delegators :@community, :submit, :result, :dom, :screenshot, :search
  end
end
