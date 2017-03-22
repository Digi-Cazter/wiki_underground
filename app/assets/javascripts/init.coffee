$ ->
  init_login()
  init_header()
  init_search()

init_header = ->
  $('.dropdown').dropdown()
  $('.profile-dropdown').dropdown()

init_login = ->
  $('body').on 'blur', '#email-login', (e) ->
    $.get('/profile/lookup', { email: @.value }).done (data) ->
      if data.avatar
        $('#avatar-login').attr('src', data.avatar)
        $('#welcome-name').html(data.name)
        $('#welcome').show()

init_search = ->
  nbaTeams = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('team')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch: '../data/nba.json'
  );