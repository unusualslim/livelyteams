Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => "cases#index"


  get "pages/:page" => "pages#show"

  devise_for :users
  #devise_scope :user do
    # Redirests signing out users back to sign-in
  #  get "users", to: "devise/sessions#new"
  #end
  devise_scope :user do
    get "users", to: "devise/sessions#new"
    match '/sessions/user', to: 'devise/sessions#create', via: :post
#    root :to => "cases#index"
  end

  resources :admin, only: [:index]
  resources :assets, only: [:index, :show]
  resources :tags
  resources :sessions
#  resources :teams do
#    resources :team_members
#  end
  #resources :user
  resources :things
  resources :notes
  resources :severities
  resources :statuses
  resources :contacts
#  resources :team_members, only: [:index, :update, :show, :destroy]

  resources :assets do
    resources :taggings
  end

  resources :locations do
    resources :assets
  end

  namespace :admin do
    resources :manufacturers, :equipment
  end

  resources :task_lists do
    resources :tasks
  end

  resources :tasks do
    resources :task_comments
  end

  resources :cases do
    resources :case_comments
    collection do
      get 'closed'
      get 'billable'
    end
    put :change_status_to_closed, on: :member
    put :change_status_to_complete_billable, on: :member

  end

#  post "change_filename", to: "things#change_filename", as: "change_filename"
#  post "set_current_team", to: "teams#set_current_team", as: 'set_current_team'
#  match '*_missing_page', to: 'pages#not_found', via: :get


end
