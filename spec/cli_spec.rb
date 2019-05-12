require 'json'

RSpec.describe UrlScan::CLI do
  describe "#submit", vcr: { cassette_name: "UrlScan_API/_submit/1_1_1" } do
    it do
      output = capture(:stdout) { described_class.start(%w(submit wikipedia.org)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  describe "#result", vcr: { cassette_name: "UrlScan_API/_result/1_2_1" } do
    it do
      output = capture(:stdout) { described_class.start(%w(result 7f0aa2ab-748a-4cae-b648-71e324e836cd)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  context "#search", vcr: { cassette_name: "UrlScan_API/_search/1_3_1" } do
    it do
      output = capture(:stdout) { described_class.start(%w(search domain:wikipedia.org)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  describe "#dom", vcr: { cassette_name: "UrlScan_API/_result/1_4_1" } do
    it do
      output = capture(:stdout) { described_class.start(%w(dom 7f0aa2ab-748a-4cae-b648-71e324e836cd)) }
      expect(output).to be_a(String)
    end
  end
end
