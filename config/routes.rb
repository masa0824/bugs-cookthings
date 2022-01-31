Rails.application.routes.draw do
  root to: 'sessions#new'
  # ログイン
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # ユーザ
  get '/users/edit_pw', to: 'users#edit_pw', as: 'edit_pw'
  patch '/users/edit_pw', to: 'users#update_edit_pw'
  # パスワードリマインダー
  get '/users/reset_password', to: 'users#reset_password', as: 'reset_password'
  post '/users/reset_password', to: 'users#reset_password_sendmail'
  get '/users/reset_password/:token/edit', to: 'users#reset_password_edit', as: 'reset_password_edit'
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
