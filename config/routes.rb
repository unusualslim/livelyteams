Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => "cases#index"

  get 'calendar/labor_hours_summary', to: 'calendar#labor_hours_summary'
  get 'calendar/labor_hours_report', to: 'calendar#labor_hours_report'
  resources :calendar, only: [:index] do
    get 'labor_hours', on: :collection
  end
  get "pages/:page" => "pages#show"
  get :search, controller: :pages
  post '/incoming-email', to: 'incoming_emails#create'

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  #devise_scope :user do
    # Redirests signing out users back to sign-in
  #  get "users", to: "devise/sessions#new"
  #end
  devise_scope :user do
    get "users", to: "devise/sessions#new"
    match '/sessions/user', to: 'devise/sessions#create', via: :post
    patch 'users/update_preferences', to: 'users/registrations#update_preferences', as: :update_user_preferences
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
    get :search, on: :collection
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

  resources :case_comments, only: [:index]

  resources :cases do
    get :search, on: :collection
    resources :case_comments
    collection do
      get 'closed'
      get 'billable'
      get 'inspectable'
    end
    put :change_status_to_inspectable, on: :member
    put :change_status_to_closed, on: :member
    put :change_status_to_complete_billable, on: :member

  end

#  post "change_filename", to: "things#change_filename", as: "change_filename"
#  post "set_current_team", to: "teams#set_current_team", as: 'set_current_team'
#  match '*_missing_page', to: 'pages#not_found', via: :get


end
