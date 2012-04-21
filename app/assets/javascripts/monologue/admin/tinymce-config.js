$(function() {
  $('textarea').tinymce({
    theme: 'advanced',
    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,separator,justifyleft,justifycenter,justifyright, justifyfull,bullist,numlist,undo,redo,link,unlink",
    theme_advanced_buttons2 : "formatselect, removeformat, indent, outdent, image, code",
    theme_advanced_buttons3 : "",
    theme_advanced_blockformats : "p,h1,h2,h3,h4,h5,h6,blockquote,dt,dd,code,samp",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "bottom",


    plugins : "fullscreen",
    theme_advanced_buttons3_add : "fullscreen",
    fullscreen_new_window : true,
    fullscreen_settings : {
            theme_advanced_path_location : "top"
    }
    
  });
});