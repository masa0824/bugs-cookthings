$(function(){
    // アカウント削除確認
    //$(document).on("click", "#acount_delete", function(){
    //    if(!confirm('本当に削除しますか？')){
    //        return false;
    //    }
    //});

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

    // アカウント画像の上限警告
    $("#GAZOU").bind("change", function() {
        var size_in_megabytes = this.files[0].size/1024/1024;
        if (size_in_megabytes > 5) {
          alert("ファイルは5MB以下にして下さい");
          $("#micropost_image").val("");
        }
    });

    // 利用規約を開く
    $('#open_rule').on('click', function() {
        window.open('/rule',"WindowName","width=700,height=512,resizable=no,scrollbars=yes");
        return false;
    });
});
