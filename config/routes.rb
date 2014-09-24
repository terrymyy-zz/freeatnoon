Rails.application.routes.draw do
  get "landing_pages/home"
  get "bye" => "landing_pages#bye"
  get "twiml" => "smses#twiml"

  post "welcome" => "smses#send_welcome_message"
  get "send_policy/:id" => "smses#send_policy"
  post "reminder" => "users#send_reminder"

  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    root "devise/registrations#new"
    get "sign_up", to: "devise/registrations#new"
    get "sign_in", to: "devise/sessions#new"
    get "sign_out", to: "devise/sessions#destroy"
  end

  resources :users, only: [:index, :show, :destroy] do
    member do
      post "toggle_mute"
    end
  end
  resources :free_times
  resources :bad_dates
  resources :smses
end
