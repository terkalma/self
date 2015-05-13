$ ->
  $(document).on 'click', '[data-target=#goToProjects]', (e)->
    e.preventDefault()
    window.location = '/admin/projects'

  $('#userEventsTable').dataTable
    processing: true
    serverSide: true
    ajax: $('#userEventsTable').data 'source'
    autoWidth: false
    order: [[ 4, 'desc' ]]
    columnDefs: [
      className: "visible-lg", "targets": [ 3, 4 ]
    ]
