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

    // 材料[単位]のプルダウン処理[チェンジ]
    $('select[placeholder="単位"]').on('change', function() {
        chenge_massunit_type($(this));
    });

    // 材料[単位]のプルダウン処理[入力タイプ変更]
    chenge_massunit_type = (_this) => {
        console.log(_this);
        if(_this.val() === '＜直接入力＞'){
            let tag_name = $(_this).attr('name');
            let tag_id = $(_this).attr('id');
            //console.log(tag_name);
            //console.log(tag_id);
            // 入力タイプの変更
            _this.replaceWith('<input required="required" placeholder="単位" type="text" name="'+tag_name+'" id="'+tag_id+'">');
        }
    }
});
