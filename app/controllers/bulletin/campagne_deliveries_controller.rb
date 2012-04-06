module Campagne
  class CampagneDeliveriesController < ApplicationController

    def see
      if delivery = CampagneDelivery.find_by_token(params[:token])
        delivery.see!(request)
      end
      image = File.read(File.join(Rails.root, "public/1x1.gif"))
      send_data image, :type => "image/gif", :disposition => "inline"
    end

    def click
      if delivery = CampagneDelivery.find_by_token(params[:token])
        delivery.click!(request)
      end
      # TODO:
      redirect_to "http://#{params[:link]}"
    end

    def unsubscribe
      if delivery = CampagneDelivery.find_by_token(params[:token])
        delivery.unsubscribe!(request)
        render :text => 'Ok'
      else
        render :text => 'Error'
      end
    end

    def bounce
      if delivery = CampagneDelivery.find_by_token(params[:token])
        delivery.bounce!
        render :text => 'Ok'
      else
        render :text => 'Error'
      end
    end

  end
end
