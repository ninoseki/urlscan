require "dotenv/load"
require "rspec"
require "urlscan"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<CENSORED/>") { ENV["URLSCAN_API_KEY"] }
  config.hook_into :webmock
end
