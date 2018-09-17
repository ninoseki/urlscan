require "dotenv/load"

require 'coveralls'
Coveralls.wear!

require "rspec"
require "urlscan"
require "vcr"

RSpec.configure do |config|
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<CENSORED/>") { ENV["URLSCAN_API_KEY"] }
  config.hook_into :webmock
end
