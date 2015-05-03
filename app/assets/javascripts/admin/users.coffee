$ ->
  $('button[data-target=#goToProjects]').on 'click', (e)->
    e.preventDefault()
    window.location = '/admin/projects'