$(document).ready ->
  $('select').material_select()

  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 2
  });
