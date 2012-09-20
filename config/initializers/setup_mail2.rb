Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address  => "mail2.darmasoft.com",
  :port     => 25,
  :domain   => "darmasoft.com",
  :user_name => "darrik@darmasoft.com",
  :password   => "wiscons9n",
  :autentication => 'plain',
  :enable_starttls_auto => true
}
