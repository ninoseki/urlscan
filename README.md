# urlscan

[![Gem Version](https://badge.fury.io/rb/urlscan.svg)](https://badge.fury.io/rb/urlscan)
[![Ruby CI](https://github.com/ninoseki/urlscan/actions/workflows/test.yml/badge.svg)](https://github.com/ninoseki/urlscan/actions/workflows/test.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/c6625486f2d57039adef/maintainability)](https://codeclimate.com/github/ninoseki/urlscan/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/urlscan/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/urlscan?branch=master)

## Description

[urlscan.io](https://urlscan.io/) API wrapper for Ruby.

## Installation

```bash
gem install urlscan
```

## API usage

```ruby
require "urlscan"

# when given nothing, it tries to load your API key from ENV["URLSCAN_API_KEY"]
api = UrlScan::API.new
# or you can set it manually
api = UrlScan::API.new(api_key)

# Submit a URL to scan
res = api.submit("https://wikipedia.org")

# Get a scan result
res = api.result("ac04bc14-4efe-439d-b356-8384843daf75")

# Get a DOM
res = api.dom("ac04bc14-4efe-439d-b356-8384843daf75")

# Search
res = api.search("wikipedia.org")
```

## Supported API endpoints

| HTTP Method | URI                     | API method                                                                                                                                 |
|-------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| POST        | /scan                   | `UrlScan::Clients::Community#submit(url, customagent: nil, referer: nil, visibility: nil, tags: nil, override_safety: nil, country: nil))` |
| GET         | /result/`uuid`/         | `UrlScan::Clients::Community#result(uuid)`                                                                                                 |
| GET         | /dom/`uuid`/            | `UrlScan::Clients::Community#dom(uuid)`                                                                                                    |
| GET         | /screenshots/`uuid`.png | `UrlScan::Clients::Community#screenshot(uuid)`                                                                                             |
| GET         | /search                 | `UrlScan::Clients::Community#search(q, size: 100, search_after: nil)`                                                                      |

### Pro

| HTTP Method | URI                     | API method                                                                                                                                    |
|-------------|-------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| GET         | /brands                 | `UrlScan::Clients::Pro#brands`                                                                                                                |
| GET         | /kits                   | `UrlScan::Clients::Pro#kits`                                                                                                                  |
| GET         | /phishfeed              | `UrlScan::Clients::Pro#phishfeed(q: "result.task.time:>now-24h", format: "json", limit: ni)`                                                  |
| GET         | /result/`uuid`/similar/ | `UrlScan::Clients::Pro#similar(uuid, q: nil, size: nil, search_after: nil, threshold: nil, min_size: nil, method: nil, resource_types: nil))` |

## CLI usage

```bash
$ urlscan
Commands:
  urlscan dom [UUID]         # get the DOM of a scan using the scan id [UUID]
  urlscan help [COMMAND]     # Describe available commands or one specific command
  urlscan result [UUID]      # get the result of a scan using the scan id [UUID]
  urlscan screenshot [UUID]  # get the screenshot(image/png) of a scan using the scan id [UUID]
  urlscan search [QUERY]     # search for scans by [QUERY]
  urlscan submit [URL]       # submit a scan to [URL]

Options:
  [--API-KEY=API_KEY]

```
