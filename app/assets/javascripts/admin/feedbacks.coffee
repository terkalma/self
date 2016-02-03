ready = ->
  statusFilter = $("select[name='statusFilter']")
  $('select').select2()

  table = $('#feedbacksTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#feedbacksTable').data 'source'
    autoWidth: false
    order: [[ 1, 'desc' ]]
    fnServerParams: (aoData) ->
      aoData.status_filter = statusFilter.val()

  statusFilter.on "change", ->
    table.fnDraw()
  return

$(document).ready ready
$(document).on 'page:load', ready