Devise.setup do |config|
  config.mailer_sender = "admin@chillingeffects.org"

  require 'devise/orm/active_record'

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.password_length = 8..128

  config.email_regexp = /\A[^@]+@[^@]+\z/

  config.reset_password_within = 6.hours

  config.secret_key = 'ceff2d792f6927ad29747d60c5573931ada1017ef3ae3f02554f4a85905797e17a7989b2da4d0e46b741ca99c6c440da540a72daaf68ad39be2bf3d5a44c1512'

  config.allow_insecure_token_lookup = true
end
