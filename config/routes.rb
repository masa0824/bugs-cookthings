Rails.application.routes.draw do
  root to: 'sessions#new'
  # ログイン
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # ユーザ
  resource :users
  # レシピ
  get '/recipes/search', to: 'recipes#search'
  post '/recipes/search', to: 'recipes#search'
  post '/recipes/search/output', to: 'recipes#output'
  get '/recipes/catalog/:date_param', to: 'recipes#catalog', as: 'catalog_recipe'
  get '/recipes/day_catalog/:date_param', to: 'recipes#day_catalog', as: 'day_catalog_recipe'
  post '/recipes/catalog/copy/:id', to: 'recipes#copy', as: 'copy_recipe'
  resources :recipes

  # テスト
  get '/user/test', to: 'users#test'
end
