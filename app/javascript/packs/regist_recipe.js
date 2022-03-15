$(function(){
    // レシピ登録の数量を半角数字のみ
    /** アイフォンで連続キー入力される疑いがあるため一旦除外
    $(document).on('click change keyup input', '[type="number"]', function(e){
        let value = $(e.currentTarget).val();
        value = value
            .replace(/[０-９]/g, function(s) {
                return String.fromCharCode(s.charCodeAt(0) - 65248);
            })
            .replace(/[^0-9]/g, '');
        $(e.currentTarget).val(value);
    });
    **/
});
