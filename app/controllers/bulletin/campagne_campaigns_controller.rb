module Campagne
  class CampagneCampaignsController < ApplicationController
    respond_to :html, :xml
    layout 'campagne/campagne'

    def index
      @campaigns = CampagneCampaign.all
    end

    def show
      @campaign = CampagneCampaign.find(params[:id])
      respond_with(@campaign)
    end

    def new
      @campaign = CampagneCampaign.new
      respond_with(@campaign)
    end

    def create
      @campaign = CampagneCampaign.new(params[:campagne_campagne_campaign])
      flash[:notice] = 'Campaign was successfully created.' if @campaign.save
      respond_with(@campaign, :location => campagne_campagne_campaigns_path)
    end

    def edit
      @campaign = CampagneCampaign.find(params[:id])
      respond_with(@campaign)
    end

    def update
      @campaign = CampagneCampaign.find(params[:id])
      flash[:notice] = 'Campaign was successfully updated.' if @campaign.update_attributes(params[:campagne_campagne_campaign])
      respond_with(@campaign)
    end

    def preview
      @campaign = CampagneCampaign.find(params[:id])
      render :layout => nil
    end

    def deliveries
      @campaign = CampagneCampaign.find(params[:id])
      @deliveries = @campaign.campagne_deliveries
    end

    def schedule
      @campaign = CampagneCampaign.find(params[:id])
      datetime = Time.zone.local(
        params[:schedule][:"at(1i)"].to_i,
        params[:schedule][:"at(2i)"].to_i,
        params[:schedule][:"at(3i)"].to_i,
        params[:schedule][:"at(4i)"].to_i,
        params[:schedule][:"at(5i)"].to_i
      )
      Resque.enqueue_at(datetime, Campagne::SenderJob, @campaign.id)
      redirect_to campagne_campagne_campaign_path(@campaign), :notice => 'Campaign was successfully scheduled.'
    end


  end
end
