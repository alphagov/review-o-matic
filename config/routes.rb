Reviewomatic::Application.routes.draw do

  scope '__' do

    devise_for :users, :token_authentication_key => :access_token, :skip => [:sessions]
    devise_scope :user do
      get 'sign_in' => 'devise/sessions#new', :as => :new_user_session
      get 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
    end

    resources :reviews, :only => [:index]
    post 'reviews/:id' => 'reviews#create', :as => :review
    get 'reviews/section' => 'reviews#section', :as => :reviews_section

    get 'explore' => 'explore#show', :as => :explore
    get 'dashboard/missing_mappings' => 'dashboard#missing_mappings', :as => :missing_mappings

    root :to => 'explore#index'

  end

  match 'dashboard/missing_mappings' => redirect('/__/dashboard/missing_mappings')
  match 'reviews' => redirect('/__/reviews')
  match '/sign_in' => redirect('/')
  match '/sign_out' => redirect('/')
  match '/' => 'root#index'

end
