Rails.application.routes.draw do
  root to: 'sessions#new'
  # ログイン
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # アカウント登録
  get '/users/account_activation/:token/edit', to: 'users#account_activation_edit', as: 'account_activation_edit'
  # パスワード変更
  get '/users/edit_pw', to: 'users#edit_pw', as: 'edit_pw'
  patch '/users/edit_pw', to: 'users#update_edit_pw'
  # パスワードリマインダー
  get '/users/reset_password', to: 'users#reset_password', as: 'reset_password'
  post '/users/reset_password', to: 'users#reset_password_sendmail'
  get '/users/reset_password/:token/edit', to: 'users#reset_password_edit', as: 'reset_password_edit'
  patch '/users/reset_password_update', to: 'users#reset_password_update', as: 'reset_password_update'
  #アカウント削除
  get '/users/account_delete', to: 'users#account_delete', as: 'account_delete'
  resource :users
  # レシピ
  get '/recipes/search', to: 'recipes#search'
  post '/recipes/search', to: 'recipes#search'
  post '/recipes/search/output', to: 'recipes#output'
  get '/recipes/catalog/:date_param', to: 'recipes#catalog', as: 'catalog_recipe'
  get '/recipes/day_catalog/:date_param', to: 'recipes#day_catalog', as: 'day_catalog_recipe'
  post '/recipes/catalog/copy/:id', to: 'recipes#copy', as: 'copy_recipe'
  # テンプレートレシピを使った新規カレンダーレシピ追加
  post '/recipes/tplnew', to: 'recipes#create2', as: 'recipe_tplnew'
  # テンプレートレシピの登録
  get '/recipes/regist_list', to: 'recipes#regist_list', as: 'regist_list_recipe'
  get '/recipes/regist_new', to: 'recipes#regist_new', as: 'regist_new_recipe'
  post '/recipes/regist_new', to: 'recipes#regist_create'
  # テンプレートレシピ編集
  get '/recipes/regist_edit/:id', to: 'recipes#regist_edit', as: 'regist_edit_recipe'
  # テンプレートレシピ更新
  patch '/recipes/regist_edit/:id', to: 'recipes#regist_update'
  # テンプレートレシピ削除
  delete '/recipes/regist_delete/:id', to: 'recipes#regist_destroy', as: 'regist_delete'
  # レシピ画像の削除[テンプレート・カレンダー共通]
  delete '/recipes/:id/edit', to: 'recipes#image_destroy', as: 'image_recipe_delete'
  # レシピ画像の選択
  get '/recipes/img_select', to: 'recipes#img_select'
  resources :recipes
  # 利用規約
  get '/rule', to: 'sessions#rule'
  # お知らせ[news]
  get '/news', to: 'sessions#news'
  get '/news/:id', to: 'sessions#news_article', as: 'article'

  # テスト
  get '/user/test', to: 'users#test'
end
