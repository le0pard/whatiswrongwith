$(document).ready(function(){
  
  var CORE ={};

  (function(){
    CORE.tooltip = new ToolCounter('.textarea');
    klass =ToolCounter.prototype;
    
    function ToolCounter(selector){
      this.area = $(selector);
      this.total = this.area.attr("maxlength");
      this.area.after('<div class="back"></div>');
      var offset = this.area.offset();
      this.back = $('.back');
      this.back.css({'left': offset.left, 'top': offset.top});
      this.back.css({
        "height": this.area.outerHeight(),
        "width": this.area.outerWidth(),
        "overflow-y": "auto"
      });
      this.back.append('<span class="tooltip">255</span>');
    }

    klass.init = function(){
      var self = this;
      this.area.keyup(function(){
        self.copyText();
      });
      
      this.area.focus(function(){
        $('.tooltip').show();
      });
      this.area.blur(function(){
        $(".tooltip").hide();
      });
    }
    
    klass.copyText =function(){
      var text = this.area.val();
      symbols = this.total - text.length;
      text = text.replace(/\n/g, "<br />");
      this.back.html(text+'<span class="tooltip" style="display:inline;">'+symbols+'</span>');
      this.back.scrollTop(this.area.scrollTop());
      return true;
    }
  })();
  
CORE.tooltip.init();
});