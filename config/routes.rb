Rails.application.routes.draw do
    root 'questions#index'

  
    resources :questions do 
      resources :answers, :only => [:create, :edit, :destroy, :update] 
    end 

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  end
