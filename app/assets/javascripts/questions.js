$(document).ready(function() {
    var bindEvents = function() {
        $('#new_Q form').on('click', 'input[type="submit"]', submitNewQuestion);
        $('body').on('click', '.button_to input[type="submit"]', runVote);
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
          clearForm();
        })
        .fail(function(response) {
          console.log("error", response);
          // renderErrors(response);
        });
    };

    var rendernewQuestion = function(response){
       var html = $('#new-question-form').html();
        var generateNewQuestionForm = Handlebars.compile(html);
        $('#questions_box').append(generateNewQuestionForm(response));
    };

    var clearForm = function(){
    $('#question_title').val('');
    $('#question_content').val('');
    };

    // var renderErrors = function(response){
    //   console.log("error");
    //   console.log(response.responseText);
    //   $('#errors').val('');
    //   $('#errors').val(response[responseText]);
    // };

    var runVote = function(event){
      event.preventDefault();
      // console.log($(this).parent().attr("action"));
      // console.log($(this).attr("value"));
      var $url = $(this).parent().attr("action");
      $.ajax({
        url: $url,
        type: 'POST',
        dataType: 'json'
      })
      .done(function(response) {
        console.log("success", response, response.vote_count);
        renderNewVotes(response);
      })
      .fail(function(response) {
        console.log("error", response);
      });
    };

    var renderNewVotes= function(response){
      var Qid = response.id;
      $('#id_'+Qid+' .vote_count span').text('Votes: '+response.vote_count+'');
    };


// At runtime: 

    bindEvents();
});