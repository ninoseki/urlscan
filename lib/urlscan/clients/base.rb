# frozen_string_literal: true

require "net/https"
require "json"

module UrlScan
  module Clients
    class Base
      VERSION = 1
      HOST = "urlscan.io"

      attr_reader :key

      def initialize(key = ENV["URLSCAN_API_KEY"])
        @key = key
      end

      private

      def url
        @url ||= "https://#{HOST}/api/v#{VERSION}"
      end

      def url_for(path)
        URI(url + path)
      end

      def https_options
        if proxy = ENV["HTTPS_PROXY"]
          uri = URI(proxy)
          {
            proxy_address: uri.hostname,
            proxy_port: uri.port,
            proxy_from_env: false,
            use_ssl: true
          }
        else
          { use_ssl: true }
        end
      end

      def request(req)
        Net::HTTP.start(HOST, 443, https_options) do |http|
          response = http.request(req)

          case response.code
          when "200"
            if response["Content-Type"].to_s.include? "application/json"
              yield JSON.parse(response.body)
            else
              yield response.body
            end
          when "400" then raise ProcessingError, response.body
          when "401" then raise AuthenticationError, response.body
          when "404" then raise NotFound, response.body
          when "429" then raise RateLimited, response.body
          when "500" then raise InternalServerError, response.body
          else
            raise ResponseError, response.body
          end
        end
      end

      def default_headers
        @default_headers ||= { "API-KEY": key }.compact
      end

      def get(path, params = {}, &block)
        uri = url_for(path)
        uri.query = URI.encode_www_form(params)

        get = Net::HTTP::Get.new(uri, default_headers)
        request(get, &block)
      end

      def post(path, json, &block)
        post = Net::HTTP::Post.new(url_for(path), default_headers)
        post.content_type = "application/json"
        post.body = json.to_json

        request(post, &block)
      end
    end
  end
end
