$ ->
  $(document).on 'ajax:beforeSend', ->
    NProgress.start()

  $(document).on 'ajax:complete', ->
    NProgress.done()