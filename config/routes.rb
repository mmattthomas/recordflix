Rails.application.routes.draw do
  
  resources :tracks do 
    resources :likes
  end

  resource :messages do
    collection do
      post 'getsms'
    end
  end

  resources :teams
  resources :comments
  resources :movies do
    member { post 'checkout' }
    member { post 'checkin' }
  end
  
  authenticated :user do
    root to: "tracks#index", as: :authenticated_root
  end
  
  unauthenticated do
    root to: 'visitors#index'
  end

  devise_for :users, :controllers => { registrations: 'registrations' }  
  resources :users  

end
