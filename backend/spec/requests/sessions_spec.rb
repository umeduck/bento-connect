require "rails_helper"

RSpec.describe "Slack OAuth", type: :request do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new(
      provider: "slack",
      uid: "U123456",
      info: { name: "duck", image: "https://example.com/avatar.png" }
    )
  end

  it "redirects with JWT on success" do
    get "/auth/slack/callback"
    expect(response).to redirect_to(/token=/)
  end
end