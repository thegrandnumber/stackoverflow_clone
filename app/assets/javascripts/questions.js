$(document).ready(function() {
    var bindEvents = function() {
        $('#new_Q form').on('click', 'input[type="submit"]', submitNewQuestion);
    };

    var submitNewQuestion = function(event) {
        event.preventDefault();
        console.log("you clicked me!!!");
        console.log($(this).parent().parent().attr("action"));
        var url = $(this).parent().parent().attr("action");
        var $form = $(this).parent().parent();
        $.ajax({
          url: url,
          type: 'POST',
          dataType: 'json',
          data: $form.serialize(),
        })
        .done(function(response) {
          console.log("success", response);
          rendernewQuestion(response);
        })
        .fail(function(response) {
          console.log("error", response);
          renderErrors(response);
        });
        

    };


// At runtime: 

    bindEvents();
});