$(document).ready(function() {
  var bindEvents= function(){
    $('body').on('click', '.new_A form input[type="submit"]', createNewAnswer);
  };

var createNewAnswer = function(event) {
    event.preventDefault();
     console.log($(this).parent().attr("action"));
     $url= $(this).parent().attr("action");
     $form = $(this).parent();
     $.ajax({
       url: $url,
       type: 'POST',
       dataType: 'json',
       data: $form.serialize(),
     })
     .done(function(response) {
       renderNewAnswer(response);
     })
     .fail(function(response) {
       renderAerrors(response);
     });
    };

    var renderNewAnswer = function(response){
      console.log("success", response);
    };

    var renderAerrors = function(response){
      console.log("error", response);
    };


  // At run time: 
  bindEvents();
});