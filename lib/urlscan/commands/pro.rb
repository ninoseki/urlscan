# frozen_string_literal: true

module UrlScan
  module Commands
    class Pro < Base
      desc "search", "search for scans"
      method_option :size, type: :numeric, default: 50
      method_option :query, type: :string
      method_option :filter, type: :string
      def search
        with_error_handling do
          res = api.pro.search(query: options["query"], filter: options["filter"], size: options["size"])
          puts JSON.pretty_generate(res)
        end
      end
    end
  end
end
