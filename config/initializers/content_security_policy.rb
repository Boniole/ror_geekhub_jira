Rails.application.config.content_security_policy do |policy|
  policy.connect_src :self, "https://kotello.space"
end