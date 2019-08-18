# frozen_string_literal: true

require "json"
require "thor"

module UrlScan
  class CLI < Thor
    class_option :API_KEY, type: :string

    desc "submit [URL]", "submit a scan to [URL]"
    method_option :public, type: :boolean, default: true
    def submit(url)
      with_error_handling do
        res = api.submit(url, options[:public])
        puts JSON.pretty_generate(res)
      end
    end

    desc "result [UUID]", "get the result of a scan using the scan id [UUID]"
    def result(uuid)
      with_error_handling do
        res = api.result(uuid)
        puts JSON.pretty_generate(res)
      end
    end

    desc "search [QUERY]", "search for scans by [QUERY]"
    method_option :size, type: :numeric, default: 100
    method_option :offset, type: :numeric, default: 0
    method_option :sort, type: :string, default: "_score"
    def search(query)
      with_error_handling do
        res = api.search(query, size: options["size"], offset: options["offset"], sort: options["sort"])
        puts JSON.pretty_generate(res)
      end
    end

    desc "dom [UUID]", "get the DOM of a scan using the scan id [UUID]"
    def dom(uuid)
      with_error_handling do
        res = api.dom(uuid)
        puts res
      end
    end

    desc "screenshot [UUID]", "get the screenshot(image/png) of a scan using the scan id [UUID]"
    def screenshot(uuid)
      with_error_handling do
        res = api.screenshot(uuid)
        puts res
      end
    end

    no_commands do
      def api
        options["API_KEY"] ? API.new(options["API_KEY"]) : API.new
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
