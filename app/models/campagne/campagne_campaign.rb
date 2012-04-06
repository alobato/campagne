module Campagne
  class CampagneCampaign < ActiveRecord::Base
    has_and_belongs_to_many :campagne_lists
    has_many :campagne_deliveries  

    attr_accessible :name, :subject, :body, :campagne_list_ids

    validates :name, :presence => true, :uniqueness => true
    validates :subject, :presence => true
    validates :body, :presence => true

    def formated_body(token)
      formated_body = body.gsub('||WB||', "<img src=\"#{Rails.application.config.campagne_base_url}/campagne/see/#{token}\" width=\"1\" height=\"1\" />")
      formated_body = formated_body.gsub('||UNSUB||', "#{Rails.application.config.campagne_base_url}/campagne/unsubscribe/#{token}")
      formated_body = formated_body.gsub('||LINK||', "#{Rails.application.config.campagne_base_url}/campagne/click/#{token}?link=")
      # formated_body = formated_body.gsub('||VIEW||', "#{Rails.application.config.campagne_base_url}/campagne/preview/#{token}")
      formated_body
    end

    def preview
      formated_body('0')
    end

  end
end
