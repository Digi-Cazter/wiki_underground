$ ->
  init_login()
  init_header()
  init_search()
  init_footer()

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

init_footer = ->
  changeFont = (fontSize) ->
    return ->
      $('html').css('font-size', fontSize + '%');
      sessionStorage.setItem('fSize', fontSize);

    normalFont = changeFont(100)
    mediumFont = changeFont(115)
    largeFont  = changeFont(125)

    $('.js-font-decrease').on 'click', ->
      normalFont()

    $('.js-font-normal').on 'click', ->
      mediumFont()

    $('.js-font-increase').on 'click', ->
      largeFont()

    if sessionStorage.length !== 0
      $('html').css('font-size', sessionStorage.getItem('fSize') + '%')