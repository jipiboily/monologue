$(document).ready (function(){
   
   var preview = {
      el: null,
      
      // initialize - bind events, etc.
      init: function(selector) {
         this.el = $(selector);
         if (this.el.length == 0) { return;}
         $(this.el.attr("data-trigger")).click(this, this.open);
         this.el.find("[data-dismiss='post-preview']").click(this, this.close);
      },
      
      // open preview
      open: function(e) {
         var el = e.data.el;
         var iframe = el.find("iframe")[0];
         if(iframe.contentDocument){
            var doc = iframe.contentDocument;
         }
         else if(iframe.contentWindow){
            var doc = iframe.contentWindow.document;
         } else {
            var doc = iframe.document;
         }

         $("#post_content").val(CKEDITOR.instances["post_content"].getData()); // update textarea with CKEDITOR content.
         $.post(el.attr("data-url"), $("form").serialize(), function(data) {
            doc.open();
            doc.writeln(data);
            doc.close();
            $(doc).keydown(e.data, e.data.keydown);   
         });

         // show preview & hide scrollbars
         el.show();
         $("body").attr("style", "overflow:hidden;");

         // look for esc
         $(document).on("keydown.post-preview", e.data, e.data.keydown);
      },
      
      // close preview on esc key.
      keydown: function(e) {
         if (e.keyCode==27) {
            e.data.close();
         }
      },
      
      // close preview
      close: function(e) {
         var el = (e==undefined)? this.el: e.data.el;
         el.hide();
         $("body").attr("style", "overflow:auto;");
         $(document).off("keydown.post-preview");
      }
   }
   
   
   // initialize preview.
   preview.init("[data-toggle='post-preview']");
})