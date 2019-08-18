# frozen_string_literal: true

require 'net/https'
require 'json'

require 'urlscan/exceptions'

module UrlScan
  class API
    VERSION = 1
    HOST = "urlscan.io"
    URL = "https://#{HOST}/api/v#{VERSION}"

    attr_reader :key

    def initialize(key = ENV["URLSCAN_API_KEY"])
      @key = key
    end

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
    def search(q, size = 100, offset = 0, sort = "_score")
      params = { q: q, size: size, offset: offset, sort: sort }
      query = URI.encode_www_form(params)
      get("/search/?#{query}") { |json| json }
    end

    def url_for(path)
      URI(URL + path)
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
        when '200'
          if response["Content-Type"].to_s.include? "application/json"
            yield JSON.parse(response.body)
          else
            yield response.body
          end
        when '400' then raise ProcessingError, response.body
        when '401' then raise AuthenticationError, response.body
        when '404' then raise NotFound, response.body
        when '429' then raise RateLimited, response.body
        when '500' then raise InternalServerError, response.body
        else
          raise ResponseError, response.body
        end
      end
    end

    def auth_header
      { "API-KEY": key }
    end

    def get(path, &block)
      get = Net::HTTP::Get.new(url_for(path))
      request(get, &block)
    end

    def post(path, json, &block)
      post = Net::HTTP::Post.new(url_for(path), auth_header)
      post.content_type = 'application/json'
      post.body = json.to_json

      request(post, &block)
    end
  end
end
