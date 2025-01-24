Rails.application.routes.draw do
  # Wrap all routes in a locale scope
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "pages#home"
    resources :contacts, only: [ :create ]
  end

  # Keep this outside the locale scope
  get "switch_locale/:locale", to: "locales#update", as: :switch_locale

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
