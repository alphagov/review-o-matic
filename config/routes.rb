Reviewomatic::Application.routes.draw do

  scope '__' do

    devise_for :users, :token_authentication_key => :access_token, :skip => [:sessions]
    devise_scope :user do
      get 'sign_in' => 'devise/sessions#new', :as => :new_user_session
      get 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
    end

    resources :reviews, :only => [:update, :index]
    post 'reviews/:id' => 'reviews#create'
    get 'reviews/section' => 'reviews#section', :as => :reviews_section

    get 'explore' => 'explore#show', :as => :explore

    root :to => 'explore#index'

  end

  get 'dashboard' => 'dashboard#index', :as => :dashboard
  get 'dashboard/mosaic' => 'dashboard#mosaic', :as => :mosaic
  get 'browse/:id' => 'browse#show', :as => :browse_mapping
  get 'browse' => 'browse#index', :as => :browse

  match 'reviews' => redirect('/__/reviews')
  match '/sign_in' => redirect('/__/sign_in')
  match '/sign_out' => redirect('/__/sign_out')
  match '/' => 'root#index'

end
