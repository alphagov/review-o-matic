Reviewomatic::Application.routes.draw do

  scope '__' do

    devise_for :users, :token_authentication_key => :access_token, :skip => [:sessions]
    devise_scope :user do
      get 'sign_in' => 'devise/sessions#new', :as => :new_user_session
      get 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
    end

    resources :reviews, :only => [:update, :index]
    get 'reviews/section' => 'reviews#section', :as => :reviews_section

    get 'browse/:id' => 'browse#show', :as => :browse_mapping
    get 'browse' => 'browse#index', :as => :browse

    get 'dashboard' => 'dashboard#index', :as => :dashboard
    get 'dashboard/mosaic' => 'dashboard#mosaic', :as => :mosaic

    root :to => 'root#index'

  end

  root :to => 'root#index'

end
