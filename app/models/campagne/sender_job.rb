# encoding: UTF-8
module Campagne
  class SenderJob
    @queue = :default

    def self.generate_token
      token = rand(36**18).to_s(36)
      token = token.gsub('+', '')
      while CampagneDelivery.where(:token => token).first do
        token = rand(36**18).to_s(36)
      end
      token
    end

    def self.perform(campaign_id)
      ActiveSupport::BufferedLogger.new(Rails.root.join('log/resque.log')).info([Time.now.iso8601, $$, "I", "---PERFORM---", campaign_id].join("\t"))
      campaign = Campaign.find(campaign_id)
      contacts = campaign.lists.map(&:contacts).flatten
      contacts = contacts.sort_by {rand} # shuffle
      contacts.each do |contact|
        next if campaign.deliveries.where(:contact_id => contact.id).first
        token = generate_token
        Sender.deliver_email(contact.email, campaign.subject, campaign.formated_body(token), token)
        campaign.deliveries.create(:contact_id => contact.id, :email => contact.email, :token => token)
      end
    end

  end
end
