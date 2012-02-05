/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	skin : 'office2003';
	config.toolbar = 'Monologue_default';
	config.height = '50em';
	
	
	config.toolbar_Monologue_default =
  [
  	{ name: 'document', items : [ 'Source' ] },
  	{ name: 'tools', items : [ 'Maximize', 'ShowBlocks' ] },
  	{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
  	{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
  	{ name: 'colors', items : [ 'TextColor','BGColor' ] },
  	{ name: 'insert', items : [ 'Image','Table','HorizontalRule','SpecialChar'] },
  	'/',
  	{ name: 'styles', items : [ 'Format' ] },
  	{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
  	{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
  	{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] }
  ];
  
	
};
