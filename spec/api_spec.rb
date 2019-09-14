# frozen_string_literal: true

RSpec.describe UrlScan::API, :vcr do
  let(:api) { described_class.new }
  let(:uuid) { "7f0aa2ab-748a-4cae-b648-71e324e836cd" }

  describe "#submit" do
    it do
      json = api.submit("https://www.wikipedia.org/", true)
      expect(json["message"]).to eq("Submission successful")
    end
  end

  describe "#result" do
    it do
      json = api.result(uuid)
      expect(json).to be_a(Hash)
    end
  end

  describe "#search" do
    it do
      json = api.search("domain:wikipedia.org")
      expect(json).to be_a(Hash)
    end
  end

  describe "#dom" do
    it do
      dom = api.dom(uuid)
      expect(dom).to be_a(String)
    end
  end

  describe "#screenshot" do
    it do
      screenshot = api.screenshot(uuid)
      expect(screenshot).to be_a(String)
    end
  end

  describe "#pro.search" do
    it do
      json = api.pro.search(query: "domain:wikipedia.org")
      expect(json).to be_a(Hash)
    end

    context "when given a filter" do
      it do
        json = api.pro.search(filter: "phishing_microsoft")
        expect(json).to be_a(Hash)
      end
    end
  end

  describe "#pro.brands" do
    it do
      json = api.pro.brands
      expect(json).to be_a(Hash)
    end
  end

  describe "#pro.kits" do
    it do
      json = api.pro.kits
      expect(json).to be_a(Hash)
    end
  end
end
