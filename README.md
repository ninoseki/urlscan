# UrlScan

[![Build Status](https://travis-ci.org/ninoseki/urlscan.svg?branch=master)](https://travis-ci.org/ninoseki/urlscan)
[![Maintainability](https://api.codeclimate.com/v1/badges/c6625486f2d57039adef/maintainability)](https://codeclimate.com/github/ninoseki/urlscan/maintainability)

## Description

Ruby API client for [urlscan.io](https://urlscan.io/)

## Usage

Initialize the API:

```ruby
require 'urlscan'
api = UrlScan::API.new(api_key)
```

Initialize the API by using `$URLSCAN_API_KEY` environment variable:

```ruby
api = UrlScan::API.new
```

Submit:

```ruby
res = api.submit("https://wikipedia.org")
puts res["result"] # => "https://urlscan.io/result/ac04bc14-4efe-439d-b356-8384843daf75/"
```

Result:

```ruby
res = api.result("ac04bc14-4efe-439d-b356-8384843daf75")
p res # => See the following URL as an example of the response.
      #    https://gist.github.com/ninoseki/a974d7e95629813615b380c30e737825#file-result-json
```

Search:

```ruby
res = api.search("wikipedia.org")
p res  # => See the following URL as an example of the reponse.
       #    https://gist.github.com/ninoseki/a974d7e95629813615b380c30e737825#file-search-json
```
