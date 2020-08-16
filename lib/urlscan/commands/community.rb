# frozen_string_literal: true

module UrlScan
  module Commands
    class Community < Base
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
      method_option :search_after, type: :string
      def search(query)
        with_error_handling do
          res = api.search(query, size: options["size"], search_after: options["search_after"])
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
    end
  end
end
