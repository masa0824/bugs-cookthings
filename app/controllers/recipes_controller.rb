class RecipesController < ApplicationController
  before_action :logged_in_user

  def index
    @menu_page_title = 'Cookthings'
    @recipes = Recipe.all.where(user_id: current_user.id)
  end

  def day_catalog
    @menu_page_title = 'レシピ追加'
    @recipes = Recipe.all.where(user_id: current_user.id, cook_at: params[:date_param].to_date.beginning_of_day...params[:date_param].to_date.end_of_day)
    @cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
  end

  def catalog
    @menu_page_title = 'レシピ一覧'
    #@recipes = Recipe.all.where(is_original: true, user_id: current_user.id)
    #@recipes = Recipe.includes(:food_stuffs).all.where(is_original: true, user_id: current_user.id)
    @recipeTemplates = RecipeTemplate.includes(:food_stuff_templates).all.where(user_id: current_user.id)
    @cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
  end

  def new
    @cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
    #@user_total_capacity = user_total_capacity
    #@user_limit_info = user_limit_info
    #@regist_recipe = user_regist_recipe
    get_user_info
    # テンプレートレシピを利用するかしないかで分岐
    if !params[:recipe_tpl_id]
      @recipe = Recipe.new
      @recipe.food_stuffs.build
    else
      @recipeTemplate = RecipeTemplate.includes(:food_stuff_templates).find_by(id: params[:recipe_tpl_id], user_id: current_user.id)
      render 'newByTpl.html'
    end
  end

  def show
    #@recipe = Recipe.includes(:food_stuffs).find(session[:user_id])
    @recipe = Recipe.includes(:food_stuffs).find_by(id: params[:id], user_id: current_user.id)
  end

  def search
    @recipes = nil
    if params.present?
      # 入力がない場合、月初
      from = params[:from_date].present? ? params[:from_date] : Time.current.beginning_of_month
      # 入力がない場合、月末
      to = params[:to_date].present? ? params[:to_date] : Time.current.end_of_month
      @recipes = Recipe.where(user_id: current_user.id, cook_at: from...to).order(cook_at: "asc")
    end
    render :search
  end

  def output
    # 選択したチェックボックスを配列にする
    recipe_ids = []
    params[:recipe_ids].each do | di1,di2 |
      recipe_ids << di1 if di2 == "1"
    end
    # レシピ＆材料取得
    @recipes = Recipe.includes(:food_stuffs).where(id: recipe_ids).order(cook_at: "asc")
  end

  # カレンダーレシピの登録
  def create
    @recipe = Recipe.create(recipe_param)
    @recipe.is_original = true
    @recipe.user_id = current_user.id

    if @recipe.save
      flash[:success] = "登録しました"
      @recipes = Recipe.all.where(user_id: current_user.id)
      redirect_to recipes_path
    else
      flash.now[:danger] = "なにかちがう"
      render :new
    end
  end

  # テンプレートレシピを使ってカレンダーレシピを登録
  def create2
    @recipe = Recipe.new(recipe_param2)
    @recipeTemplate = RecipeTemplate.new(regist_recipe_param(false))
    # @recipeモデルに値を追加
    @recipe.recipe_name = @recipeTemplate.recipe_name
    @recipe.category = @recipeTemplate.category
    @recipe.cook_at = @recipeTemplate.cook_at
    @recipe.user_id = current_user.id
    @recipe.is_original = true
    @recipeTemplate.food_stuff_templates.each do | fst |
      @recipe.food_stuffs.build(
        food_stuff: fst.food_stuff,
        amount: fst.amount,
        mass: fst.mass
      )
    end

    if @recipe.save
      flash[:success] = "登録しました"
      @recipes = Recipe.all.where(user_id: current_user.id)
      redirect_to recipes_path
    else
      flash.now[:danger] = "なにかちがう"
      render :new
    end
  end

  def edit
    #@recipe = Recipe.includes(:food_stuffs).find(session[:user_id])
    @recipe = Recipe.includes(:food_stuffs).find_by(id: params[:id], user_id: current_user.id)
    #@user_total_capacity = user_total_capacity
    #@user_limit_info = user_limit_info
    #@regist_recipe = user_regist_recipe
    get_user_info
  end

  def destroy
    #@recipe = Recipe.find(session[:user_id])
    @recipe = Recipe.find_by(id: params[:id], user_id: current_user.id)
    @recipe.destroy
    redirect_to recipes_path, notice:"削除しました"
  end

  def update
    #@recipe = Recipe.find(session[:user_id])
    @recipe = Recipe.find_by(id: params[:id], user_id: current_user.id)
    if @recipe.update(recipe_param)
      redirect_to recipes_path, notice: "編集しました"
    else
      flash[:danger] = 'えらー'
      redirect_to edit_recipe_path
    end
  end

  def copy
    # レシピのクローン作成
    recipe = Recipe.find(current_user.id)
    new_recipe = recipe.dup
    new_recipe.cook_at = params[:date_param]
    new_recipe.is_original = false
    
    # 材料のクローン作成
    fs = FoodStuff.where(recipe_id: current_user.id)
    fs.find_each do | f |
      new_fs = new_recipe.food_stuffs.build(recipe_id: new_recipe.id)
      new_fs.food_stuff = f.food_stuff
      new_fs.amount = f.amount
      new_fs.mass = f.mass
    end

    # レシピ保存
    new_recipe.save

    # レシピ取得
    @recipes = Recipe.all.where(user_id: current_user.id)
    # カレンダートップに遷移
    redirect_to recipes_path
  end

  # テンプレートレシピ表示
  def regist_list
    @menu_page_title = 'レシピ登録'
    @recipeTemplates = RecipeTemplate.includes(:food_stuff_templates).all.where(user_id: current_user.id)
    #@cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
  end

  # テンプレートレシピ新規入力
  def regist_new
    @recipeTemplates = RecipeTemplate.new
    @recipeTemplates.food_stuff_templates.build
    #@user_total_capacity = user_total_capacity
    #@user_limit_info = user_limit_info
    #@regist_recipe = user_regist_recipe
    get_user_info
    #@cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
  end
  
  # テンプレートレシピ新規登録
  def regist_create
    @recipeTemplates = RecipeTemplate.create(regist_recipe_param)
    #@recipe.is_original = true
    @recipeTemplates.user_id = current_user.id
    if @recipeTemplates.save
      flash[:success] = "登録しました"
      @recipeTemplates = Recipe.all.where(user_id: current_user.id)
      redirect_to recipes_path
    else
      flash.now[:danger] = "なにかちがう"
      render :new
    end
  end

  # テンプレートレシピ編集
  def regist_edit
    @recipeTemplate = RecipeTemplate.includes(:food_stuff_templates).find_by(id: params[:id], user_id: current_user.id)
    #@user_total_capacity = user_total_capacity
    #@user_limit_info = user_limit_info
    #@regist_recipe = user_regist_recipe
    get_user_info
  end

  # テンプレートレシピ更新
  def regist_update
    @recipeTemplate = RecipeTemplate.find_by(id: params[:id], user_id: current_user.id)
    if @recipeTemplate.update(regist_recipe_param)
      # 「選択用レシピ画像」が選択されたら「アップロードレシピ画像」を削除する
      @recipeTemplate.select_images_id != 0 ? @recipeTemplate.recipe_template_image.purge : false
      redirect_to recipes_path, notice: "編集しました"
    else
      flash[:danger] = 'えらー'
      redirect_to regist_edit_recipe_path
    end
  end

  # テンプレートレシピ削除
  def regist_destroy
    @recipeTemplate = RecipeTemplate.find_by(id: params[:id], user_id: current_user.id)
    @recipeTemplate.destroy
    redirect_to recipes_path, notice:"削除しました"
  end

  # レシピ画像の削除[テンプレート・カレンダー共通]
  def image_destroy
    #@user_total_capacity = user_total_capacity
    #@user_limit_info = user_limit_info
    #@regist_recipe = user_regist_recipe
    get_user_info

    case params[:target]
      when 'recipe_image'
        @recipe = Recipe.includes(:food_stuffs).find_by(id: params[:id], user_id: current_user.id)
        @recipe.recipe_image.purge
        render 'edit'
      when 'recipe_template_image'
        @recipeTemplate = RecipeTemplate.includes(:food_stuff_templates).find_by(id: params[:id], user_id: current_user.id)
        @recipeTemplate.recipe_template_image.purge
        render 'regist_edit'
    end
  end

  # レシピ画像選択
  def img_select
    @selectImages = SelectImage.where.not(id: 0)
  end
  
  private

  def get_user_info
    @user_total_capacity = user_total_capacity
    @user_limit_info = user_limit_info
    @regist_recipe = user_regist_recipe
  end

  def recipe_param
    params.require(:recipe).permit(
        :cook_at, 
        :recipe_name,
        :category,
        :recipe_image,
        :select_images_id,
        food_stuffs_attributes:[
            :id,
            :food_stuff,
            :amount,
            :mass,
            :_destroy
        ]
    )
  end

  def recipe_param2
    params.require(:recipe_template).permit(
        :cook_at, 
        :recipe_name,
        :category,
        :recipe_image,
        :select_images_id,
        food_stuffs_attributes:[
            :id,
            :food_stuff,
            :amount,
            :mass,
            :_destroy
        ]
    )
  end

  def regist_recipe_param(need_id=true)
    if need_id
      params.require(:recipe_template).permit(
        :cook_at, 
        :recipe_name,
        :category,
        :recipe_template_image,
        :select_images_id,
        food_stuff_templates_attributes:[
            :id,
            :food_stuff,
            :amount,
            :mass,
            :_destroy
        ]
      )
    else
      params.require(:recipe_template).permit(
        :cook_at, 
        :recipe_name,
        :category,
        :recipe_template_image,
        :select_images_id,
        food_stuff_templates_attributes:[
            #:id,
            :food_stuff,
            :amount,
            :mass,
            :_destroy
        ]
      )
    end
  end
end
