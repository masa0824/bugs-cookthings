class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def catalog
    @recipes = Recipe.all.where(is_original: true)
    @cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
  end

  def new
    @recipe = Recipe.new
    @recipe.food_stuffs.build
    @cook_at = params[:date_param].present? ? params[:date_param].to_date : Date.today
  end

  def show
    @recipe = Recipe.includes(:food_stuffs).find(params[:id])
  end

  def search
    @recipes = nil
    if params.present?
      # 入力がない場合、月初
      from = params[:from_date].present? ? params[:from_date] : Time.current.beginning_of_month
      # 入力がない場合、月末
      to = params[:to_date].present? ? params[:to_date] : Time.current.end_of_month
      @recipes = Recipe.where(cook_at: from...to).order(cook_at: "asc")
    end
    render :search
  end

  def output
    recipe_ids = []
    params[:recipe_ids].each do | di1,di2 |
      recipe_ids << di1 if di2 == "1"
    end
    @recipes = Recipe.includes(:food_stuffs).where(id: recipe_ids).order(cook_at: "asc")
  end

  def create
    @recipe = Recipe.create(recipe_param)
    @recipe.is_original = true
    if @recipe.save
      flash[:success] = "登録しました"
      @recipes = Recipe.all
      redirect_to recipes_path
    else
      flash.now[:danger] = "なにかちがう"
      render :new
    end
  end

  def edit
    @recipe = Recipe.includes(:food_stuffs).find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice:"削除しました"
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_param)
      redirect_to recipes_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def copy
    # レシピのクローン作成
    recipe = Recipe.find(params[:id])
    new_recipe = recipe.dup
    new_recipe.cook_at = params[:date_param]
    new_recipe.is_original = false
    
    # 材料のクローン作成
    fs = FoodStuff.where(recipe_id: params[:id])
    fs.find_each do | f |
      new_fs = new_recipe.food_stuffs.build(recipe_id: new_recipe.id)
      new_fs.food_stuff = f.food_stuff
      new_fs.amount = f.amount
      new_fs.mass = f.mass
    end

    # レシピ保存
    new_recipe.save

    # レシピ取得
    @recipes = Recipe.all
    # カレンダートップに遷移
    redirect_to recipes_path
  end

  private

  def recipe_param
    params.require(:recipe).permit(
        :cook_at, 
        :recipe_name,
        :category,
        food_stuffs_attributes:[
            :id,
            :food_stuff,
            :amount,
            :mass,
            :_destroy
        ]
    )
  end
end
