$(document).ready(function() {
	// Este código corre después de que `document` fue cargado(loaded) 
	// completamente. 
	// Esto garantiza que si amarramos(bind) una función a un elemento 
	// de HTML este exista ya en la página. 

  $('#form_exit').hide();

  $('#form').submit(function(event) {
    event.preventDefault();
    console.log("Test");
    $('#spinner').css('visibility', 'visible');

    value_form = $("#handle_text").val();

    $.get('/twiter/'+ value_form, function (data) {
      
      console.log(data);
      $("#form").hide()
      $('#spinner').hide();
      $('#intro1').hide();
      $('#intro2').hide();
      $('#intro3').hide();
      $("#submit_button_exit").hide();
      $("#form_logout").hide();
      $("#submit_button").hide();
      $("#form_tweet").hide();
      $('#form_exit').show();
      $("#form_exit").html(data);

    });

  });


  $('#form_tweet').submit(function(event) {
    event.preventDefault();
    $('#spinner').css('visibility', 'visible');
    $("#form_logout").hide();

   value_form = $("#tweet_text").val();

    $.post('/tweet', { tweet_text: value_form }, 
      function (data) {
      window.location.href = "/";

      });


    

  });






});
