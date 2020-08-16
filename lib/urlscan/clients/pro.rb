# frozen_string_literal: true

module UrlScan
  module Clients
    class Pro < Base
      VERSION = 1
      HOST = "pro.urlscan.com"

      # @return [Hash]
      def search(query: nil, filter: nil, size: 50)
        filter = build_filter(filter)
        params = { q: query, size: size, filter: filter }.compact
        get("/search", params) { |json| json }
      end

      # @return [Hash]
      def brands
        get("/brands") { |json| json }
      end

      # @return [Hash]
      def kits
        get("/kits") { |json| json }
      end

      # @return [Hash]
      def phishfeed(q: "result.task.time:>now-24h", format: "json")
        params = { q: q, format: format }
        get("/phishfeed", params) { |json| json }
      end

      # @return [Hash]
      def similar(uuid)
        get("/result/#{uuid}/similar") { |json| json }
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
