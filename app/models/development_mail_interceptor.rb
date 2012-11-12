class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "<#{`whoami`.strip}> #{message.to} #{message.subject}"
    message.to = "developer@trueinteraction.com"
  end
end
