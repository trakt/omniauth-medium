describe OmniAuth::Strategies::Medium do

  def build_access_token
    VCR.use_cassette "access_token" do
      request.params["code"] = ENV["AUTH_CODE"]
      callback_url = "http://localhost:4567"
      expect(subject).to receive(:callback_url).and_return(callback_url)
      subject.access_token = subject.send(:build_access_token)
    end
  end

  let(:request) do
    double('Request', params: {}, cookies: {}, env: {}, scheme: nil)
  end

  let(:app) do
    lambda { [200, {}, "Hello."] }
  end

  subject do
    subject = described_class.new(
      app,
      ENV["CLIENT_ID"],
      ENV["CLIENT_SECRET"],
      @options || {},
    )

    # Can't do this setup in a before block because subject can't be called
    #   before @options has a chance to be set.
    allow(subject).to receive(:request).and_return(request)
    subject.instance_eval { @env ||= {} }

    subject
  end

  it { is_expected.to be_a OmniAuth::Strategies::OAuth2 }

  it "is called medium" do
    expect(subject.name).to eq "medium"
  end

  it "has correct site" do
    expect(subject.client.site).to eq "https://api.medium.com/v1"
  end

  it "has correct authorize_url" do
    authorize_url = "https://medium.com/m/oauth/authorize"
    expect(subject.client.options[:authorize_url]).to eq authorize_url
  end

  it "has correct token_url" do
    token_url = "https://api.medium.com/v1/tokens"
    expect(subject.client.options[:token_url]).to eq token_url
  end

  describe "scope" do
    def self.it_handles_scope(input, output = input)
      it "allows #{input} as #{output}" do
        @options = { scope: input }
        expect(subject.authorize_params["scope"]).to eq output
      end
    end

    # It doesn't change string scopes.
    it_handles_scope SecureRandom.hex

    it_handles_scope :basic_profile, "basicProfile"
    it_handles_scope :publish_post, "publishPost"
    it_handles_scope %i[basic_profile publish_post], "basicProfile,publishPost"

    it "defaults to basicProfile,publishPost" do
      default = "basicProfile,publishPost"
      expect(subject.authorize_params["scope"]).to eq default
    end
  end

  # @note if you are running this test with VCR playback disabled, you will
  #   need to obtain a fresh authorization code. The bin/authorize utility will
  #   assist in this process.
  describe "#access_token" do
    before do
      build_access_token
    end

    it "resolves request URLs correctly" do
      # WebMock.stub_request(:get, "https://api.medium.com/v1/me")

      # # if it requests the right URL, WebMock will intercept and there'll be no
      # #   exception. Otherwise, VCR will raise an UnhandledHTTPRequestError.
      # x = subject.access_token.get("me")
    end
  end

  describe "#info" do
    it "returns the result of v1/me" do
      build_access_token
      data = JSON.parse(File.read("#{__dir__}/../../fixtures/me.json"))["data"]

      VCR.use_cassette "me" do
        expect(subject.send(:info)).to eq data
      end

      # needs to cache
      # called outside VCR so will raise an exception if called again
      expect(subject.send(:info)).to eq data
    end
  end

  describe "#uid" do
    it "returns info.id" do
      value = Object.new
      allow(subject).to receive(:info).and_return("id" => value)
      expect(subject.uid).to eq value
    end
  end

end
