$ ->
  $(document).on 'click', '[data-target=#goToProjects]', (e)->
    e.preventDefault()
    window.location = '/admin/projects'