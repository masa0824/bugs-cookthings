$(function(){
  /***
   * 親ウインドウ
   */
  // 「画像選択」と「画像アップロード」の切り替え
  $('input[name="check[img]"]:radio').change(function(){
    var radioval = $(this).val();
    switch(radioval){
      case '1':
        $('#recipe_img_upload').hide();
        $('#recipe_img_select').show();
        break;
      case '2':
        $('#recipe_img_upload').show();
        $('#recipe_img_select').hide();
        break;
      default:
    }
  });

  // フォーム送信処理
  $('form').submit(function(){
    let radioval = $('input[name="check[img]"]:radio').val();
    if(radioval == '2'){
      $('#select_images_id').val(0);
    }
  });

  // レシピ画像の選択処理[親]
  let target;
  $('#recipe_img_select').on('click', function(){
    //子から値が来た際に更新するセレクト要素
    target = $(this).closest('.form-group').find('select');
    
    //子を開く
    window.open(
      '/recipes/img_select', 
      '子ウィンドウの名前らしい', 
      'width=700, height=600, directories=no, menubar=no, toolbar=no, location=no, scrollbars=yes'
    );
  });

  /***
   * 子ウインドウ
   */
  // レシピ画像の選択処理[子]
  $('#image_set').on('click', function(){
    // 親ウィンドウの存在をチェック
    if(!window.opener || window.opener.closed){ 
        alert('error'); 
        window.close();
    }
    //親の関数を呼ぶ
    window.opener.setSelect($('input[type="radio"]:checked').val());
    window.close();
  });
});