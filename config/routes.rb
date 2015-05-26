Rails.application.routes.draw do
    root 'questions#index'

  
    resources :questions do 
      member do 
        post 'upvote'
        post 'downvote'
      end 
      resources :answers do 
        member do 
          post 'upvote'
          post 'downvote'
        end 
      end 
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
