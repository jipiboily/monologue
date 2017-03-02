$(function() {

//    Full configuation can be found under  http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Toolbar
    CKEDITOR.config.toolbar = 'Basic';
    CKEDITOR.config.toolbar_Basic =
    [
    	{ name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
    	{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
    	{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
    	{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
        '/',
    	{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
    	'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
    	{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
    	{ name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
    	'/',
    	{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
    	{ name: 'colors', items : [ 'TextColor','BGColor' ] },
    	{ name: 'tools', items : [ 'Maximize', 'ShowBlocks' ] }
    ];
    CKEDITOR.config.disableNativeSpellChecker = false;
}());