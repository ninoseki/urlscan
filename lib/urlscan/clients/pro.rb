# frozen_string_literal: true

module UrlScan
  module Clients
    class Pro < Base
      VERSION = 1
      HOST = "pro.urlscan.com"

      def initialize(key = ENV["URLSCAN_API_KEY"])
        super key

        raise ArgumentError, "API key is required for this class." if key.nil?
      end

      # @return [Hash]
      def search(query: nil, filter: nil, size: 50)
        filter = build_filter(filter)
        params = { q: query, size: size }.compact
        uri_query = URI.encode_www_form(params)
        uri_query << "&filter=#{filter}" if filter

        get("/search?#{uri_query}") { |json| json }
      end

      # @return [Hash]
      def brands
        get("/brands") { |json| json }
      end

      # @return [Hash]
      def kits
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
