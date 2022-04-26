$(function(){
    $('#menu-btn_humberger').on('click', function(){
      $('.menu').toggleClass('is-active');
    });

    //
    // ヘルプボタン機能
    //
    $('#menu-btn_help').on('click', function() {
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
    });

    // ヘルプの表示順を指定
    switch (location.pathname) {
      // トップページ
      case '/recipes':
        $('[data-step="A1"]').attr('data-step', '1');
        $('[data-step="A2"]').attr('data-step', '2');
        $('[data-step="A3"]').attr('data-step', '3');
        $('[data-step="A4"]').attr('data-step', '4');
        $('[data-step="A5"]').attr('data-step', '5');
        $('[data-step="A6"]').attr('data-step', '6');
        break;
      // ユーザーページ
      case '/users/edit':
        $('[data-step="B1"]').attr('data-step', '1');
        $('[data-step="B2"]').attr('data-step', '2');
        $('[data-step="B3"]').attr('data-step', '3');
        $('[data-step="B4"]').attr('data-step', '4');
        $('[data-step="B5"]').attr('data-step', '5');
        break;
      default:
    }
}());