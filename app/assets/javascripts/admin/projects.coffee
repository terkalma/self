# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'change', '#userRateToggle', (e) ->
  $('#userRate').find('input').val ''
  $('#userRate').toggleClass 'hide'


ready = ->
  $('#projectsTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#projectsTable').data 'source'
    autoWidth: false
    order: [[ 1, 'desc' ]]

  $('select').select2()
  $('.report-container .datepicker').customDatepicker {
    orientation: 'bottom'
  }

  $(document).on 'submit', '.report-container form', ->
    $(this).find('input').prop 'disabled', true

$(document).ready ready
$(document).on 'page:load', ready
