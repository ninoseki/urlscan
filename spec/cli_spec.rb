# frozen_string_literal: true

require 'json'

RSpec.describe UrlScan::CLI do
  let(:uuid){ "7f0aa2ab-748a-4cae-b648-71e324e836cd" }

  describe "#submit", vcr: { cassette_name: "UrlScan_API/_submit/1_1_1" } do
    it do
      output = capture(:stdout) { described_class.start(%w(submit wikipedia.org)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  describe "#result", vcr: { cassette_name: "UrlScan_API/_result/1_2_1" } do
    it do
      output = capture(:stdout) { described_class.start(["result", uuid]) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  describe "#search", vcr: { cassette_name: "UrlScan_API/_search/1_3_1" } do
    it do
      output = capture(:stdout) { described_class.start(%w(search domain:wikipedia.org)) }
      json = JSON.parse(output)
      expect(json).to be_a(Hash)
    end
  end

  describe "#dom", vcr: { cassette_name: "UrlScan_API/_result/1_4_1" } do
    it do
      output = capture(:stdout) { described_class.start(["dom", uuid]) }
      expect(output).to be_a(String)
    end
  end

  describe "#screenshot", vcr: { cassette_name: "UrlScan_API/_result/1_5_1" } do
    it do
      output = capture(:stdout) { described_class.start(["screenshot", uuid]) }
      expect(output).to be_a(String)
    end
  end

  describe "#pro.search", vcr: { cassette_name: "UrlScan_API/_pro_search/1_6_1" } do
    it do
      output = capture(:stdout) { described_class.start(["pro search"]) }
      expect(output).to be_a(String)
    end
  end
end
