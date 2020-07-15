Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
    end
  end
end
