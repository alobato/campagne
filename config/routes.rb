Rails.application.routes.draw do

  namespace :campagne do
    root to: 'campagne_lists#index'
    mount Resque::Server.new, at: 'resque'
    resources :campagne_lists do
      member do
        get 'import'
        post 'import'
      end
    end
    resources :campagne_campaigns do
      member do
        get 'preview'
        get 'deliveries'
        post 'schedule'
      end
    end
    get 'see/:token' => 'campagne_deliveries#see'
    get 'click/:token' => 'campagne_deliveries#click'
    get 'unsubscribe/:token' => 'campagne_deliveries#unsubscribe'
    get 'bounce/:token' => 'campagne_deliveries#bounce'
  end

end
