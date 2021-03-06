Eggs::Application.routes.draw do
  resources :location_tags

  get "subscriptions/index"
  get "subscriptions/show"

  resources :email_templates
  resources :snippets
  match 'feedbacks' => 'feedbacks#create', :as => :feedback
  match 'feedbacks/new' => 'feedbacks#new', :as => :new_feedback
  resources :locations
  resources :account_transactions
  match 'ipn' => 'account_transactions#ipn', :as => :ipn
  resources :subscription_transactions do
    collection do
      get :new_many
      get :create_many
    end
  end
  resources :password_resets
  resources :activation_resets
  resources :members
  match '/register/:activation_code' => 'activations#new', :as => :register
  match '/activate/:id' => 'activations#create', :as => :activate
  match 'join' => 'members#new', :as => :join
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'essential_info' => 'farms#show_essential_info', :as => :essential_info
  resources :user_sessions
  resources :order_items
  resources :orders
  resources :accounts
  resources :users
  resources :stock_items
  resources :deliveries do
    resources :orders
  end

  resources :products
  resources :product_questions
  resources :farms do
    resources :deliveries do
      resources :orders
    end
  end

  resources :subscriptions

  match '/home' => 'home#index', :as => :home
  match '/' => 'home#index', :as => :root
  match '/:controller(/:action(/:id))'
end
