# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: "registrations" }
  get '/profile', to: 'profile#show', as: :profile_path
  get '/profile/lookup', to: 'profile#lookup', as: :profile_lookup_path

  get '/wiki/*slug', to: 'wiki#show'

  root to: redirect('/profile')
end
