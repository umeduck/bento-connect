Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack,
           ENV.fetch("SLACK_CLIENT_ID"),
           ENV.fetch("SLACK_CLIENT_SECRET"),
           scope: "identity.basic,channels:read,groups:write,chat:write"
end