# encoding: UTF-8
module Campagne
  class Sender

    def self.deliver_email(email, subject, email_body, token)
      sleep 0.5
      ActionMailer::Base::mail({
        :from => "#{Rails.application.config.campagne_from_name} <#{Rails.application.config.campagne_from_email}>",
        :to => email.downcase,
        :subject => subject,
        :body => email_body,
        :content_type => 'text/html; charset=UTF-8'#,
        :'Return-Path' => "bounce+#{token}@#{Rails.application.config.campagne_domain}",
        :'List-Unsubscribe' => "<mailto:unsubscribe-#{token}@#{Rails.application.config.campagne_domain}>, <#{Rails.application.config.campagne_base_url}/campagne/unsubscribe/#{token}>"
      }).deliver
    end

  end
end
