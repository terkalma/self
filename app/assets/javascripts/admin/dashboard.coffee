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

  $('#exportXls').on 'click', (e)->
    $this = $(this)

    to = $("#toDate input").val()
    from = $("#fromDate input").val()
    filter = $('#eventsTable_filter input').val()

    $params = ['from=' + from, 'to=' + to, 'search_query=' + filter].join '&'

    url = $(this).data('source') + '?' + $params

    $this.attr 'href', url

    true


  $("#fromDate input, #toDate input").on "change", ->
    table.fnDraw()
    return

  $('.datepicker').customDatepicker()