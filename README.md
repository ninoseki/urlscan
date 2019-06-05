# UrlScan

[![Build Status](https://travis-ci.org/ninoseki/urlscan.svg?branch=master)](https://travis-ci.org/ninoseki/urlscan)
[![Maintainability](https://api.codeclimate.com/v1/badges/c6625486f2d57039adef/maintainability)](https://codeclimate.com/github/ninoseki/urlscan/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/urlscan/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/urlscan?branch=master)

## Description

Ruby API client for [urlscan.io](https://urlscan.io/).

## Installation

```bash
gem install urlscan
```

## API usage

```ruby
require 'urlscan'

# when given nothing, it tries to load your API key from ENV["URLSCAN_API_KEY"]
api = UrlScan::API.new
# or you can set it manually
api = UrlScan::API.new(api_key)

# Submit a URL to scan
res = api.submit("https://wikipedia.org")
puts res["result"] # => "https://urlscan.io/result/ac04bc14-4efe-439d-b356-8384843daf75/"

# Get a scan result
res = api.result("ac04bc14-4efe-439d-b356-8384843daf75")
p res # => See the following URL as an example of the response.
      #    https://gist.github.com/ninoseki/a974d7e95629813615b380c30e737825#file-result-json

# Get a DOM
res = api.dom("ac04bc14-4efe-439d-b356-8384843daf75")
p res

# Search
res = api.search("wikipedia.org")
p res  # => See the following URL as an example of the reponse.
       #    https://gist.github.com/ninoseki/a974d7e95629813615b380c30e737825#file-search-json
```

### Supported API endpoints

| HTTP Method | URI             | API method                                                        |
| ----------- | --------------- | ----------------------------------------------------------------- |
| POST        | /scan           | `UrlScan::API#submit(url, is_public = true)`                      |
| GET         | /result/\$uuid/ | `UrlScan::API#result(uuid)`                                       |
| GET         | /dom/\$uuid/    | `UrlScan::API#dom(uuid)`                                          |
| GET         | /search         | `UrlScan::API#search(q, size = 100, offset = 0, sort = "_score")` |

## CLI usage

```bash
$ urlscan
Commands:
  urlscan dom [UUID]      # get the DOM of a scan using the [UUID]
  urlscan help [COMMAND]  # Describe available commands or one specific command
  urlscan result [UUID]   # get the result of a scan using the [UUID]
  urlscan search [QUERY]  # search for scans by [QUERY]
  urlscan submit [URL]    # submit a scan to [URL]

Options:
  [--API-KEY=API_KEY]

```
