# frozen_string_literal: true

module UrlScan
  module Clients
    class Community < Base
      # @return [Hash]
      def submit(url, is_public = true)
        raise ArgumentError, "API key is required for this method." if key.nil?

        params = { url: url, public: is_public ? "on" : "off" }
        post("/scan/", params) { |json| json }
      end

      # @return [Hash]
      def result(uuid)
        get("/result/#{uuid}") { |json| json }
      end

      # @return [String]
      def dom(uuid)
        get("/dom/#{uuid}/") { |dom| dom }
      end

      def screenshot(uuid)
        get("/screenshots/#{uuid}.png") { |png| png }
      end

      # @return [Hash]
      def search(q, size: 100, offset: 0, sort: "_score")
        params = { q: q, size: size, offset: offset, sort: sort }
        query = URI.encode_www_form(params)
        get("/search/?#{query}") { |json| json }
      end
    end
  end
end
