$ ->
  table = $('#eventsTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#eventsTable').data 'source'
    autoWidth: false
    order: [[ 0, 'desc' ]]
    fnServerParams: (aoData) ->
      aoData.from = $("#fromDate input").val()
      aoData.to = $("#toDate input").val()

      return

  $("#fromDate, #toDate").on "change", ->
    table.fnDraw()
    return

  $('.datepicker').customDatepicker()