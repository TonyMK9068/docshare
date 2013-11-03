// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require marked
//= require_tree .

// Set default options except highlight which has no default


$(document).ready(function() {
  $( "textarea" ).keyup(function() {
    var value = $( this ).val();
    $( ".marked-text" ).html( marked(value) );
  })
  .keyup();
});

(function($) {
    $.fn.textSimple = function(content) {
        var content_array = content.split(""),
            index = 0,
            element = this;
        setInterval(function() {
            if(index < content_array.length) {
                element.text(element.text() + content_array[index++]);
            }
        }, 200);
    };
    
})(jQuery); 
//  $("#type-writer").textSimple("Welcome to Docshare");

$(document).ready(function(){
  $('.nav-tab').hover(
    function() {
      $(this).css('border-bottom', '3px solid #CC0000');
    }, function(){
      $(this).css('border-bottom', '');
    }
  );
  $('button.special').click(function(){
    $('.root-info').after("<div class='demo-row'><textarea id='demo-input' rows='6' cols='30' style='display:none;'>####Try some Markdown here....!</textarea></div>");
    $('#demo-input').fadeIn('slow');
    $('#demo-input').after("<p class='demo-text'></p>");
    $('button.special').css('display', 'none');
  });

  $(document).on('mouseover', '#demo-input', function(){
    $('#demo-input').empty();
  });

  $(document).on('click', '#demo-input', function(){
    $( "#demo-input" ).keyup(function() {
      var value = $( this ).val();
      marked.setOptions({
      gfm: true,
      highlight: function (code, lang, callback) {
      pygmentize({ lang: lang, format: 'html' }, code, function (err, result) {
      if (err) return callback(err);
      callback(null, result.toString());
        });
          },
          tables: true,
      breaks: false,
      pedantic: false,
      sanitize: true,
      smartLists: true,
      smartypants: false,
      langPrefix: 'lang-'
    });
      $( ".demo-text" ).html( marked(value) );
    })
  .keyup();
  });
  $('.close').click(function(){
    $('div.alert').slideUp('slow');
    $('div')
  });
});

$(document).ready(function(){
  $('.account').hover(
    function() {
      $('.hidden').slideDown('slow');
      $('.account').css('border-right', '3px solid #CC0000');
    }, function() {
      $('.hidden').slideUp('slow');
      $('.account').css('border-right', '');
    }
  );
});

