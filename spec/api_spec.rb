describe UrlScan::API, :vcr do
  context "#submit" do
    it "should return a response" do
      json = subject.submit("https://www.wikipedia.org/", true)
      expect(json).to be_a(Hash)
      expect(json["message"]).to eq("Submission successful")
    end

    it "should raise an error if submit a non-exist domain" do
      expect { subject.submit("https://non-exist-domain.org") }.to raise_error(UrlScan::ResponseError)
    end
  end

  context "#result" do
    it "should return a response" do
      json = subject.result("7f0aa2ab-748a-4cae-b648-71e324e836cd")
      expect(json).to be_a(Hash)
    end
  end

  context "#search" do
    it "should return a response" do
      json = subject.search("domain:wikipedia.org")
      expect(json).to be_a(Hash)
    end
  end
end
