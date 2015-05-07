$ ->
  $(document).on 'click', '[data-target=#goToProjects]', (e)->
    e.preventDefault()
    window.location = '/admin/projects'

  $('#userEventsTable').dataTable
    pagingType: "full_numbers"
    processing: true
    serverSide: true
    ajax: $('#userEventsTable').data('source')
    responsive: true
    autoWidth: false
    order: [[ 4, 'desc' ]]
