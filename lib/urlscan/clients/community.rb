# frozen_string_literal: true

module UrlScan
  module Clients
    class Community < Base
      # @return [Hash]
      def submit(url, customagent: nil, referer: nil, visibility: nil, tags: nil, override_safety: nil, country: nil)
        params = {
          url: url,
          customagent: customagent,
          referer: referer,
          visibility: visibility,
          tags: tags,
          overrideSafety: override_safety,
          country: country
        }.compact
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
      def search(q, size: 100, search_after: nil)
        params = { q: q, size: size, search_after: search_after }.compact
        get("/search/", params) { |json| json }
      end
    end
  end
end
