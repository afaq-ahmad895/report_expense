Rails.application.routes.draw do
 
 root 'expenses#index'
 resources :expenses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
