$(function() {

    $('#login-form-link').click(function(e) {
    $("#login-form").delay(100).fadeIn(100);
    $("#register-form").fadeOut(100);
    $('#register-form-link').removeClass('active');
    $(this).addClass('active');
    e.preventDefault();
  });
  $('#register-form-link').click(function(e) {
    $("#register-form").delay(100).fadeIn(100);
    $("#login-form").fadeOut(100);
    $('#login-form-link').removeClass('active');
    $(this).addClass('active');
    e.preventDefault();
  });

});

 function function_1(){
    $(".tile").height($("#tile1").width());
    $(".carousel").height($("#tile1").width());
    $(".item").height($("#tile1").width());

    $(window).resize(function () {
      if (this.resizeTO) clearTimeout(this.resizeTO);
      this.resizeTO = setTimeout(function () {
          $(this).trigger('resizeEnd');
      }, 10);
    });

    $(window).bind('resizeEnd', function () {
      $(".tile").height($("#tile1").width());
      $(".carousel").height($("#tile1").width());
      $(".item").height($("#tile1").width());
    });

 }
$(document).ready(function () {
    function_1();
     $('.tree').treegrid();
    $("#new_patient").validate({
        rules: {
        "patient[name]": {required: true, minlength: 6},
        "patient[phone]": {required: true, minlength: 10}
        }
      });

    $('input:radio[name="post[status]"]').click(function(event){
      var status = $('input:radio[name="post[status]"]:checked').val();
      var manager_id = $('#manager_id').val();
      $.ajax({
         url: 'http://localhost:3000/managers/filter_agent',
         data: {
            status : status,
            manager_id : manager_id
         },
         error: function() {
            alert("Ajax call failed.");
         },

         success: function(data) {

         },
         type: 'POST'
      });
    });
});

