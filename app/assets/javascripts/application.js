// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require caret
//= require color
//= require jquery_ujs

$(document).ready(function(){
  var textarea = $("div.textarea");
  var counter = $("span.counter");
  var cursor = $("span.cursor");
  $(textarea).html(cursor); // adding cursor emulator
  
  var symbolLimit = 255; //hardcoded symbol limit
  var symbolCount = symbolLimit;
  var textareaSymbols = $(textarea).text().replace('<span class="cursor"><!-- cursor --></span>', '').length;
  
  $(counter).text(symbolCount);
  
  function counterPositioning(el){
    //console.log($(cursor).position().left);
    $(el).css({
      "top": $(cursor).offset().top - 1,
      "left": $(cursor).offset().left + 1
    });
  }
  
  function counterToggleDown() {
    if (symbolCount > 0) {
      symbolCount = symbolCount > $(textarea).text().length ? symbolCount-1 : symbolLimit - $(textarea).text().length;
      $(counter).text(symbolCount);
    } 
  }
  
  function counterToggleUp() {
    if (symbolCount < 255) {
      symbolCount = symbolCount < $(textarea).text().length ? symbolCount+1 : symbolLimit - $(textarea).text().length;
      $(counter).text(symbolCount);
    }
  }
  
  $(textarea).focus(function(){
    counterPositioning(counter);
    $(counter).show();
  });
  
  $(textarea).blur(function(){
    $(counter).hide();
  });
  
  $(textarea).keydown(function(e){
    textareaSymbols = $(textarea).text().length;
    if (e.keyCode == '13') {
      e.preventDefault();
    }
  })
  
  $(textarea).keyup(function(){
    if ($(textarea).text().length == 0) {
      $(textarea).html(cursor).click();
    }
    counterPositioning(counter);
    if ($(textarea).text().length > textareaSymbols) {
      counterToggleDown();
    } else {
      counterToggleUp();
    }
  });
  
  $(textarea).focus();
  
});