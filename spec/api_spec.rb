describe UrlScan::API, :vcr do
  before(:context) do
    @api = UrlScan::API.new
  end

  context "#submit" do
    it "should return a response" do
      json = @api.submit("https://www.wikipedia.org/", true)
      expect(json).to be_a(Hash)
      expect(json["message"]).to eq("Submission successful")
    end
  end

  context "#result" do
    it "should return a response" do
      json = @api.result("7f0aa2ab-748a-4cae-b648-71e324e836cd")
      expect(json).to be_a(Hash)
    end
  end

  context "#search" do
    it "should return a response" do
      json = @api.search("domain:wikipedia.org")
      expect(json).to be_a(Hash)
    end
  end
end
