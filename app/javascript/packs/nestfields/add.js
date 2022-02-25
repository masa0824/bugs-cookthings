class addFields {
    
    // This executes when the function is instantiated.
    constructor(){
        this.links = document.querySelectorAll('.add_fields');
        this.iterateLinks();
    }

    iterateLinks() {
        const LimitAddMaterial = 15;
        // If there are no links on the page, stop the function from executing.
        if(this.links.length === 0) return;
        // Loop over each link on the page. A page could have multiple nested forms.
        this.links.forEach((link)=>{
            link.addEventListener('click', (e) => {
                if(this.checkInputNum() < LimitAddMaterial){
                    if(this.checkInputValue() === false){
                        alert('項目を追加するには材料を入力して下さい');
                        e.preventDefault();
                    }else{
                        this.handleClick(link, e);
                    }
                }else{
                    alert('1レシピで追加できる材料は'+ LimitAddMaterial +'個までです');
                    e.preventDefault();
                }
            });
        });
    }

    handleClick(link, e) {
        // Stop the function from executing if a link or event were not passed into the function. 
        if (!link || !e) return;
        // Prevent the browser from following the URL.
        e.preventDefault();
        // Save a unique timestamp to ensure the key of the associated array is unique.
        let time = new Date().getTime();
        // Save the data id attribute into a variable. This corresponds to `new_object.object_id`.
        let linkId = link.dataset.id;
        // Create a new regular expression needed to find any instance of the `new_object.object_id` used in the fields data attribute if there's a value in `linkId`.
        let regexp = linkId ? new RegExp(linkId, 'g') : null ;
        // Replace all instances of the `new_object.object_id` with `time`, and save markup into a variable if there's a value in `regexp`.
        let newFields = regexp ? link.dataset.fields.replace(regexp, time) : null ;
        // Add the new markup to the form if there are fields to add.
        
        //newFields ? link.insertAdjacentHTML('beforebegin', newFields) : null ;
        let food = document.querySelector('#food-stuff-table')
        newFields ? food.insertAdjacentHTML('beforeend', newFields) : null ;
    }

    // フォーム[材料]の入力値の空チェック
    checkInputValue(){
        let result = true;
        $('#food-stuff-table').find('td').find('[name^="recipe"]').each(function(i, ele) {
            if(ele.value === ''){
                return result = false;
            }
        });
        return result;
    }

    // フォーム[材料]の数チェック
    checkInputNum(){
        let none_cnt = 0;
        let td_num = $('.td1').length;
        $('.nested-fields').find('input[id$="__destroy"]').each(function(){
            if($(this).val() === '1'){
                none_cnt++;
            }
        });
        return td_num - none_cnt;
    }
}

// Wait for turbolinks to load, otherwise `document.querySelectorAll()` won't work 
window.addEventListener('turbolinks:load', () => new addFields() );