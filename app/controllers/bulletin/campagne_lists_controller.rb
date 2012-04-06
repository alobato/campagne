module Campagne
  class CampagneListsController < ApplicationController
    respond_to :html, :xml
    layout 'campagne/campagne'

    def index
      @lists = CampagneList.all
    end

    def show
      @list = CampagneList.find(params[:id])
      respond_with(@list)
    end

    def new
      @list = CampagneList.new
      respond_with(@list)
    end

    def create
      @list = CampagneList.new(params[:campagne_campagne_list])
      flash[:notice] = 'List was successfully created.' if @list.save
      respond_with(@list, :location => campagne_campagne_lists_path)
    end

    def import
      @list = CampagneList.find(params[:id])
      if request.post?
        emails = params[:emails].split("\r\n")
        emails.each do |email|
          if contact = CampagneContact.find_by_email(email)
            if !@list.contacts.exists?(contact.id)
              @list.contacts << contact
              @list.save
            end
          else
            @list.contacts.create(:email => email)
          end
        end      
        redirect_to campagne_campagne_lists_path, :notice => "Contacts were successfully imported."
      end
    end

  end
end
