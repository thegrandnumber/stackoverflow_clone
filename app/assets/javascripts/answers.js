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
       clearAnswerForm();
     })
     .fail(function(response) {
       renderAerrors(response);
     });
    };

    var renderNewAnswer = function(response){
      console.log("success", response);
      // ('#errors').html('');
       var html = $('#new-answer').html();
        var generateNewAnswerForm = Handlebars.compile(html);
        $('#answers_box').prepend(generateNewAnswerForm(response));
    };

    var clearAnswerForm = function(){
      $('#answer_title').val('');
      $('#answer_content').val('');
    };

    var renderAerrors = function(response){
      console.log("error", response);
    };


  // At run time: 
  bindEvents();
});