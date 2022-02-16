$(function(){
    // アカウント削除確認
    $(document).on("click", "#acount_delete", function(){
        if(!confirm('本当に削除しますか？')){
            return false;
        }
    });

    // アップロード画像のプレビュー
    $(document).on("change", "#GAZOU", function(){
        window.URL = window.URL || window.webkitURL;
        if(window.URL){
            //var IMGFILE = $('input[name="GAZOU"]').prop('files')[0];
            var IMGFILE = $('input[id="GAZOU"]').prop('files')[0];
            var IMGURL = window.URL.createObjectURL(IMGFILE);
            $('#DISP_GAZOU').attr("src", IMGURL).onload = function(){
                window.URL.revokeObjectURL(IMGURL);
            };

        }else{
            alert("ブラウザがサムネ表示に対応していません(´；ω；｀)");
        }
    });
});
