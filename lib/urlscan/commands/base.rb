# frozen_string_literal: true

require "json"
require "thor"

module UrlScan
  module Commands
    class Base < Thor
      class_option :API_KEY, type: :string

      no_commands do
        def api
          options.key?("API_KEY") ? API.new(options["API_KEY"]) : API.new
        end

        def with_error_handling
          yield
        rescue ArgumentError => _e
          puts "Warning: please specify your urlscan.io API key via ENV['URLSCAN_API_KEY'] or --API-KEY"
        rescue ResponseError => e
          puts "Warning: #{e}"
        end
      end
    end
  end
end
