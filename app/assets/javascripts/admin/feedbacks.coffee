ready = ->
  $('#feedbacksTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#feedbacksTable').data 'source'
    autoWidth: false
    order: [[ 1, 'desc' ]]

$(document).ready ready
$(document).on 'page:load', ready