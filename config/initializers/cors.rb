ALLOWED_ORIGINS = if Rails.env.production?
  [
    "https://v1p.dangertechnologies.com",
  ]
else
  [
    "*"
  ]
end


Rails.application.config.middleware.insert_before 0, Rack::Cors, :debug => true, :logger => (-> {Rails.logger }) do
allow do
origins ALLOWED_ORIGINS

resource '*',
headers: :any,
methods: [:get, :post, :put, :patch, :delete, :options, :head]
end
end

Rails.application.config.action_cable.disable_request_forgery_protection = true
