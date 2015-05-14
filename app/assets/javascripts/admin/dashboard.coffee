$ ->
  $('#eventsTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#eventsTable').data 'source'
    autoWidth: false
    order: [[ 0, 'desc' ]]
