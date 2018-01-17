require 'json'

describe UrlScan::CLI do
  context "#submit", vcr: { cassette_name: "UrlScan_API/_submit/should_return_a_response"} do
    it "should output a response as JSON" do
      output = capture(:stdout) { UrlScan::CLI.start(%w(submit wikipedia.org)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  context "#result", vcr: { cassette_name: "UrlScan_API/_result/should_return_a_response"} do
    it "should output a response as JSON" do
      output = capture(:stdout) { UrlScan::CLI.start(%w(result 7f0aa2ab-748a-4cae-b648-71e324e836cd)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  context "#search", vcr: { cassette_name: "UrlScan_API/_search/should_return_a_response"} do
    it "should output a response as JSON" do
      output = capture(:stdout) { UrlScan::CLI.start(%w(search domain:wikipedia.org)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end
end
