require 'json'
require 'thor'

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

    desc "result [UUID]", "get the result of a scan using the [UUID]"
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
        res = api.search(query, options[:size], options[:offset], options[:sort])
        puts JSON.pretty_generate(res)
      end
    end

    no_commands do
      def api
        options[:API_KEY] ? API.new(options[:API_KEY]) : API.new
      end

      def with_error_handling
        yield
      rescue ArgumentError => e
        puts "Warning: please specify your urlscan.io API key"
      rescue ResponseError => e
        puts "Warning: #{e.to_s}"
      end
    end
  end
end
