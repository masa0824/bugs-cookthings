$(function(){
  $(".ajax").colorbox({
    maxWidth:"80%",
    maxHeight:"80%",
    opacity: 0.7
  });
  
  $('.trig-colorbox_iframe').colorbox({
      iframe: true,
      opacity: 0.6,
      innerWidth: '80%',// 幅初期設定
      innerHeight: '80%',// 高さ初期設定
  });

  $(".colorbox").colorbox({
    inline: true,
    innerWidth: '100%',// 幅初期設定

  });

  $(document).ready(function(){
    var current_scrollY;
    $(".iframe").colorbox({
      iframe:true, width:"1000px", height:"80%",
      onOpen:function(){ current_scrollY = $( window ).scrollTop();

      $( '#wrapper' ).css( {
        position: 'fixed',
        width: '100%',
        top: -1 * current_scrollY
      } ); },
      onClosed:function(){ $( '#wrapper' ).attr( { style: '' } );$( 'html, body' ).prop( { scrollTop: current_scrollY } ); }
    });
  });
});