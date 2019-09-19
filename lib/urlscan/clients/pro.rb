# frozen_string_literal: true

module UrlScan
  module Clients
    class Pro < Base
      VERSION = 1
      HOST = "pro.urlscan.com"

      # @return [Hash]
      def search(query: nil, filter: nil, size: 50)
        raise ArgumentError, "API key is required for this method." if key.nil?

        filter = build_filter(filter)
        params = { q: query, size: size }.compact
        uri_query = URI.encode_www_form(params)
        uri_query << "&filter=#{filter}" if filter

        get("/search?#{uri_query}") { |json| json }
      end

      # @return [Hash]
      def brands
        raise ArgumentError, "API key is required for this method." if key.nil?

        get("/brands") { |json| json }
      end

      # @return [Hash]
      def kits
        raise ArgumentError, "API key is required for this method." if key.nil?

        get("/kits") { |json| json }
      end

      private

      def build_filter(filter)
        return nil unless filter

        filter.start_with?("$") ? filter : "$#{filter}"
      end

      def url
        @url ||= "https://#{self.class::HOST}/api/v#{self.class::VERSION}/pro"
      end

      def get(path, &block)
        get = Net::HTTP::Get.new(url_for(path), auth_header)
        request(get, &block)
      end
    end
  end
end
