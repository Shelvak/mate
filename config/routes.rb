Mate::Application.routes.draw do

  resources :movements do
    get :autocomplete_for_bank_name, on: :collection
    get :autocomplete_for_code_number, on: :collection
    get :autocomplete_for_client_name, on: :collection
  end

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end

  resources :advances, :banks, :cards, :clients, :codes,
    :transactions, :workplaces

  root to: 'movements#index'
end
