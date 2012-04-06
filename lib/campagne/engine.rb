# http://edgeapi.rubyonrails.org/classes/Rails/Engine.html
module Campagne
  class Engine < Rails::Engine

    initializer "campagne.load_app_instance_data" do |app|
      Campagne.setup do |config|
        config.app_root = app.root
      end
    end

    initializer "campagne.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer "campagne.load_resque_config" do |app|
      require 'resque/server'
      Resque::Server.use(Rack::Auth::Basic)
      require 'resque_scheduler'
      require 'resque_scheduler/server'
    end

  end
end
