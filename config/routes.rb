Mate::Application.routes.draw do
  resources :advances, :banks, :cards, :clients, :codes, :workplaces

  resources :movements do
    get :autocomplete_for_bank_name, on: :collection
  end

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end
  
  root to: 'users#index'
end
