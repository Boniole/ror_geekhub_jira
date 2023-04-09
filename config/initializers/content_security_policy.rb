Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.img_src :self, :https
  policy.connect_src :self, :https, 'https://kotello.space'
end