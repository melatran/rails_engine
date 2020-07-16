Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]

      get '/revenue', to: 'revenue#index'
    end
  end
end
