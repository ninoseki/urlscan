# UrlScan

[![Build Status](https://travis-ci.org/ninoseki/urlscan.svg?branch=master)](https://travis-ci.org/ninoseki/urlscan)
[![Maintainability](https://api.codeclimate.com/v1/badges/c6625486f2d57039adef/maintainability)](https://codeclimate.com/github/ninoseki/urlscan/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/urlscan/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/urlscan?branch=master)

## Description

Ruby API client for [urlscan.io](https://urlscan.io/)

## Installation

```bash
$ gem install urlscan
```

## API usage

Initialize the API:

```ruby
require 'urlscan'
# initialize the API by passing the API key.
api = UrlScan::API.new(api_key)
# or initialize the API by using `$URLSCAN_API_KEY` environment variable
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

## CLI usage

```bash
$ urlscan
Commands:
  urlscan help [COMMAND]  # Describe available commands or one specific command
  urlscan result [UUID]   # get the result of a scan using the [UUID]
  urlscan search [QUERY]  # search for scans by [QUERY]
  urlscan submit [URL]    # submit a scan to [URL]

Options:
  [--API-KEY=API_KEY]
```
