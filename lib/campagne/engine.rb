# http://edgeapi.rubyonrails.org/classes/Rails/Engine.html
module Campagne
  class Engine < Rails::Engine

    initializer "campagne.load_app_instance_data" do |app|
      Campagne.setup do |config|
        config.app_root = app.root
      end
    end

  end
end
