replace_data_step = (source, replace) => {
  $('[data-step="'+source+'"]').attr('data-step', replace);
}

$(function(){
    $('#menu-btn_humberger').on('click', function(){
      $('.menu').toggleClass('is-active');
      $('#menu-btn_help').toggleClass('is-active');
    });

    //
    // ヘルプボタン機能
    //
    $('#menu-btn_help').on('click', function() {
      //let menu_status = $('#humberger_menu').attr('class');
      //if(menu_status !== 'menu is-active'){
        //introJs().start();
        introJs().setOptions({
          'showProgress': true,
          'hidePrev': true,
          //'hideNext': true,
          'showStepNumbers': true,
          'prevLabel': '戻る',
          'nextLabel': '次へ',
          'doneLabel': '閉じる',
        }).start();
      //}
    });

    // ヘルプの表示順を指定
    let pathname = location.pathname;
    //console.log(pathname);
    switch (true){
      // トップページ
      case /\/recipes$/.test(pathname):
        replace_data_step('A1', 1);
        replace_data_step('A2', 2);
        replace_data_step('A3', 3);
        replace_data_step('A4', 4);
        replace_data_step('A5', 5);
        replace_data_step('A6', 6);
        
        break;
      // ユーザーページ
      case /\/users\/edit$/.test(pathname):
        replace_data_step('B1', 1);
        replace_data_step('B2', 2);
        replace_data_step('B3', 3);
        replace_data_step('B4', 4);
        replace_data_step('B5', 5);
        break;
      // 検索ページ
      case /\/recipes\/search$/.test(pathname):
        replace_data_step('C1', 1);
        replace_data_step('C2', 2);
        break;
      // テンプレートレシピ ページ
      case /\/recipes\/regist_list$/.test(pathname):
        replace_data_step('D1', 1);
        break;
      // テンプレートレシピ 新規追加ページ
      case /\/recipes\/regist_new$/.test(pathname):
        replace_data_step('E1', 1);
        replace_data_step('E2', 2);
        replace_data_step('E3', 3);
        replace_data_step('E4', 4);
        replace_data_step('E5', 5);
        break;
      // カレンダーレシピ ページ
      case /\/recipes\/day_catalog\/[0-9]{4}-[0-9]{2}-[0-9]{2}$/.test(pathname):
        replace_data_step('F1', 1);
        break;
      // カレンダーレシピ レシピ一覧ページ
      case /\/recipes\/catalog\/[0-9]{4}-[0-9]{2}-[0-9]{2}$/.test(pathname):
        replace_data_step('G1', 1);
        replace_data_step('G2', 2);
        break;
      // カレンダーレシピ 新規追加ページ
      case /\/recipes\/new$/.test(pathname):
        replace_data_step('H1', 1);
        replace_data_step('H2', 2);
        replace_data_step('H3', 3);
        replace_data_step('H4', 4);
        replace_data_step('H5', 5);
        replace_data_step('H6', 6);
        break;
      // カレンダーレシピ 新規追加ページ
      case /\/recipes\/[0-9]+$/.test(pathname):
        replace_data_step('I1', 1);
        replace_data_step('I2', 2);
        break;
      // カレンダーレシピ レシピ編集ページ
      case /\/recipes\/[0-9]+\/edit$/.test(pathname):
        replace_data_step('J1', 1);
        replace_data_step('J2', 2);
        replace_data_step('J3', 3);
        replace_data_step('J4', 4);
        replace_data_step('J5', 5);
        replace_data_step('J6', 6);
        break;
      // デフォルト
      default:
        break;
    }
}());