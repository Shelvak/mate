Mate::Application.routes.draw do
  
  resources :movements, except: :destroy do
    collection do
      get :autocomplete_for_bank_name
      get :autocomplete_for_code_number
      get :autocomplete_for_client_name
    end
  end

  resources :transactions do
    collection do
      get :autocomplete_for_card_name
      get :autocomplete_for_place_name
    end
  end

  resources :clients do
    get :autocomplete_for_workplace_name, on: :collection
  end

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end

  resources :advances, :banks, :cards, :codes, :places,
    :workplaces

  root to: 'movements#index'
end
