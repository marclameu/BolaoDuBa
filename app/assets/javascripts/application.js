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
//= require twitter/bootstrap
//= require jquery.ui.all
//= require_tree .
/*
$(document).ready(function() {
  var data = '2012-10-20-23:00:00'
  $("#jcountdown").setCountdown({
    //Date for the countdown
    targetDate: data,
    //Labels for days/hours/minutes/seconds,
    //[ 'Days', 'Hours', 'Minutes', 'Seconds' ] by default
    itemLabels: [ 'Dia', '', '', '' ]
  });
});
*/
var date = new Date(jQuery('#limit_date').val());
$('#contador').countdown({until: date, description: ''}); 
$(function(){
	//alert($("#championship_id option:selected").text());
	$("#championship_id").val(1);
});
$(function() {
    $( "#user_born_date" ).datepicker({
	    changeMonth: true,
		dateFormat: 'dd/mm/yy', 
		dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
		dayNamesMin: ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sab'],  
        monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julio', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'], 
        monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'], 
        changeYear: true,
		yearRange: '1950:2010'
	});
    /*$( "#anim" ).change(function() {
        $( "#user_born_date" ).datepicker( "option", "showAnim", $( this ).val() );
    });*/
});
