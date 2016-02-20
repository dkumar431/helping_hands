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

    $('input:radio[name="post[agent_status]"]').click(function(event){
      var status = $('input:radio[name="post[agent_status]"]:checked').val();
      var manager_id = $('#manager_id').val();
      $.ajax({
         url: 'http://localhost:3000/managers/filter_agent',
         data: {
            agent_status : status,
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

    $(document).on('click','.sort',function(event){
      var sort_id = $(this).attr('id');
      var sort_by = $(this).attr('sort_by');
      var sort_type = $(this).attr('sort_type');

      $('#'+sort_id).parent().parent().addClass("refresh");
      $.ajax({
         url: 'http://localhost:3000/agents/my_patients_sort',
         data: {
            sort_by : sort_by,
            sort_type : sort_type
         },
         error: function() {
            alert("Ajax call failed.");
         },

         success: function(data) {
            if (sort_type == 'asc'){
              $('#'+sort_id).attr('sort_type',"desc");
            }
            else{
              $('#'+sort_id).attr("sort_type","asc");
            }
            $('#'+sort_id).parent().parent().removeClass("refresh");

         },
         type: 'POST'
      });
    });

    $("#search").keyup(function(){

      var search_term = $("#search").val();

        console.log("key up is called.");
        $.ajax({
         url: 'http://localhost:3000/agents/search_patient',
         data: {
            search : search_term
         },
         error: function() {
            alert("Ajax call failed.");
         },

         success: function(data) {


         },
         type: 'POST'
      });


    });

    $("#login-submit").on("click",function(){
      var username = $("#username").val();
      var password = $("#password").val();
      if (username.length == 0 || password.length == 0){
        $("#errordiv").show().html("<b>Username/Password cann't be blank.</b>")
        return false;
      }

    });

});

