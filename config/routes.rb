Rails.application.routes.draw do
  resources :flats
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', registration: 'register', sign_up: 'cmon_let_me_in' }
  root to: "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "*path", to: redirect('/')
end
