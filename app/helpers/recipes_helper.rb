module RecipesHelper
    # 選択用レシピ画像パスの取得
    def get_select_image_filepath(select_images_id)
        filename = SelectImage.find(select_images_id).file_name
        return '/img/select_foods/' + filename
    end

    # レシピ画像の表示
    def show_recipe_image(r_model)
        r_model.nil? ? (return image_tag '/img/recipe_new_add.png', :class => 'recipe-image', :id => 'DISP_GAZOU') :
        if r_model.select_images_id  == 0
            val_name = (r_model.respond_to? :recipe_template_image) ? 'template_' : ''
            if r_model.send("recipe_#{val_name}image").persisted?
                return cl_image_tag r_model.send("recipe_#{val_name}image").key, :quality=>"auto", :fetch_format=>:auto, :class => 'recipe-image', :id => 'DISP_GAZOU'
            else
                return image_tag '/img/recipe_new_add.png', :class => 'recipe-image', :id => 'DISP_GAZOU'
            end
        else
            return image_tag self.get_select_image_filepath(r_model.select_images_id), :class => 'recipe-image', :id => 'DISP_GAZOU'
        end
    end

    # 「選択用レシピ画像」の値を変更する関数
    def js_get_value_by_childwindow
        return js = <<-EOS
        <script>
        var target;
        var setSelect = function(_id){
            $(target).val(_id);
            $('#select_images_id').val(_id);
        }
        </script>
        EOS
    end
end
