# frozen_string_literal: true

module UrlScan
  module Clients
    class Pro < Base
      VERSION = 1
      HOST = "urlscan.io"

      # @return [Hash]
      def brands
        get("/brands") { |json| json }
      end

      # @return [Hash]
      def kits
        get("/kits") { |json| json }
      end

      # @return [Hash]
      def phishfeed(q: "result.task.time:>now-24h", format: "json", limit: nil)
        params = { q: q, format: format, limit: limit }.compact
        get("/phishfeed", params) { |json| json }
      end

      # @return [Hash]
      def similar(uuid, q: nil, size: nil, search_after: nil, threshold: nil, min_size: nil, method: nil, resource_types: nil)
        params = {
          q: q,
          size: size,
          search_after: search_after,
          threshold: threshold,
          minSize: min_size,
          method: method,
          resourceTypes: resource_types
        }.compact
        get("/result/#{uuid}/similar/", params) { |json| json }
      end

      # @return [Hash]
      def scanners
        get("/livescan/scanners/") { |json| json }
      end

      private

      def build_filter(filter)
        return nil unless filter

        filter.start_with?("$") ? filter : "$#{filter}"
      end

      def url
        @url ||= "https://#{HOST}/api/v#{VERSION}/pro"
      end
    end
  end
end
