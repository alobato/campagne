module Campagne
  class CampagneDelivery < ActiveRecord::Base
    belongs_to :campagne_campaign

    attr_accessible :contact_id, :campagne_list_id , :email, :token

    def see!(request)
      self.ip_address = request.remote_ip if ip_address.blank?
      self.user_agent = request.user_agent if user_agent.blank?
      self.seen_at = Time.now if seen_at.nil?
      save
    end

    def click!(request)
      self.ip_address = request.remote_ip if ip_address.blank?
      self.user_agent = request.user_agent if user_agent.blank?
      self.seen_at = Time.now if seen_at.nil?
      self.clicked_at = Time.now if clicked_at.nil?
      save
    end

    def unsubscribe!(request)
      CampagneList.find(list_id).contacts.delete(CampagneContact.find(contact_id)) # Remove contact from list
      self.ip_address = request.remote_ip if ip_address.blank?
      self.user_agent = request.user_agent if user_agent.blank?
      self.seen_at = Time.now if seen_at.nil?
      self.unsubscribed_at = Time.now if unsubscribed_at.nil?
      save
    end

    def bounce!
      CampagneList.find(list_id).contacts.delete(CampagneContact.find(contact_id))
      update_attribute(:bounced_at, Time.now) if bounced_at.nil?
    end

  end
end
