Rails.application.routes.draw do

  devise_for :users

  root 'expenses#index'
  resources :expenses  do
    post :import_data, on: :collection
    collection {post :import}
  end

  get "categories/index"
  resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


