module RecipesHelper
    # 選択用レシピ画像パスの取得
    def get_select_image_filepath(select_images_id)
        filename = SelectImage.find(select_images_id).file_name
        return '/img/select_foods/' + filename
    end

    # レシピ画像の表示
    def show_recipe_image(r_model)
        r_model.nil? ? (return image_tag 'sample_xd_new_add_recipe.png', :class => 'recipe-image', :id => 'DISP_GAZOU') :
        if r_model.select_images_id  == 0
            if r_model.recipe_template_image.persisted?
                return cl_image_tag r_model.recipe_template_image.key, :quality=>"auto", :fetch_format=>:auto, :class => 'recipe-image', :id => 'DISP_GAZOU'
            else
                return image_tag 'sample_xd_new_add_recipe.png', :class => 'recipe-image', :id => 'DISP_GAZOU'
            end
        else
            return image_tag self.get_select_image_filepath(r_model.select_images_id), :class => 'recipe-image', :id => 'DISP_GAZOU'
        end
    end
end
