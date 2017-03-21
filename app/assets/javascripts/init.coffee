$ ->
  init_login()
  init_header()

init_header = ->
  $('.profile-dropdown').dropdown()

init_login = ->
  $('body').on 'blur', '#email-login', (e) ->
    $.get('/profile/lookup', { email: @.value }).done (data) ->
      if data.avatar
        $('#avatar-login').attr('src', data.avatar)
        $('#welcome-name').html(data.name)
        $('#welcome').show()
