Mate::Application.routes.draw do
  resources :advances
  resources :movements
  resources :banks

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end
  
  root to: 'users#index'
end
