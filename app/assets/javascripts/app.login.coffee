App.Login =
  init: ->
    $('body').on 'blur', '#email-login', (e) ->
      $.get('/profile/lookup', { email: @.value }).done (data) ->
        if data.avatar
          $('#avatar-login').addClass('animated flip')
          $('#avatar-login').attr('src', data.avatar)
          $('#welcome-name').html(data.name)
          $('#welcome').show()

$(document).on "turbolinks:load", ->
  return unless $('body.sessions-controller.new-action').length > 0
  App.Login.init()