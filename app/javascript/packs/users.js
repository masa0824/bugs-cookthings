$(function(){
    $(document).on("click", "#acount_delete", function(){
        if(!confirm('本当に削除しますか？')){
            return false;
        }
    });
});
