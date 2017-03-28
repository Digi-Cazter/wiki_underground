# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: "registrations" }
  get '/profile', to: 'profile#show', as: :profile_path
  get '/profile/lookup', to: 'profile#lookup', as: :profile_lookup_path

  get '/wiki/:space_slug', to: 'spaces#show'
  get '/wiki/:space_slug/*page_slug', to: 'wiki#show'

  resources :spaces, only: [:new, :create] do
    resources :wiki, only: [:new, :create] do
      post '/spaces/:space_id/wiki', to: 'wiki#create', as: :space_wiki
    end
  end

  post '/spaces/:space_id/wiki', to: 'wiki#create', as: :space_wiki

  root to: redirect('/profile')
end
