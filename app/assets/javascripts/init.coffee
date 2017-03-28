$(document).on "turbolinks:load", ->
  init_login()
  init_header()
  init_search()
  init_create_resource()
  init_footer()
  init_editor()

init_editor = ->
  new SimpleMDE(
    element: document.getElementById("editor")
    autosave:
      enabled: true
      uniqueId: "WikiHive"
      deplay: 10000
  )
  # window.simplemde.value("hello world")
init_header = ->
  $('.dropdown').dropdown()
  $('.profile-dropdown').dropdown()

init_login = ->
  $('body').on 'blur', '#email-login', (e) ->
    $.get('/profile/lookup', { email: @.value }).done (data) ->
      if data.avatar
        $('#avatar-login').addClass('animated flip')
        $('#avatar-login').attr('src', data.avatar)
        $('#welcome-name').html(data.name)
        $('#welcome').show()

init_create_resource = ->
  name_field = $('#space_name')
  slug_field = $('#space_slug')

  name_field.on 'keyup', ->
    slug_field.val(name_field.val().replace(' ', '_'))

init_search = ->
  commands = ['Create new Page', 'Create new Space']
  organizations = ['American Financing']
  people = ['Donavan White']

  substringMatcher = (strs) ->
    (q, cb) ->
      matches = undefined
      substringRegex = undefined
      # an array that will be populated with substring matches
      matches = []
      # regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i')
      # iterate through the pool of strings and for any string that
      # contains the substring `q`, add it to the `matches` array
      $.each strs, (i, str) ->
        if substrRegex.test(str)
          matches.push str
        return
      cb matches
      return

  window.typeahead_search = $('.typeahead-search').typeahead({ highlight: true, minLength: 1 }, {
      name: 'commands'
      source: substringMatcher(commands)
      templates: {
        header: '<h3 class="search-header">Shortcuts</h3>'
      }
    }, {
      name: 'organizations'
      source: substringMatcher(organizations)
      templates: {
        header: '<h3 class="search-header">Organizations</h3>'
      }
    }, {
      name: 'people'
      source: substringMatcher(people)
      templates: {
        header: '<h3 class="search-header">People</h3>'
      }
    }
  )

  window.typeahead_search.on 'keydown', ->
    clearTimeout(window.search_animation_timer)
    if $('#hive-loader').hasClass('animate') == false
      $('#hive-loader').addClass('animate')

  window.typeahead_search.on 'keyup', ->
    window.search_animation_timer = setTimeout ->
      $('#hive-loader').removeClass('animate')
    , 1000

  window.typeahead_search.on 'typeahead:selected', (obj, datum) ->
    switch datum
      when "Create new Space"
        $('#create_space').modal('show');
      when "Create new Page"
        $('#create_page').modal('show');
    $(this).typeahead("val", "")
    return

init_footer = ->
  changeFont = (fontSize) ->
    $('html').css('font-size', fontSize + '%')
    sessionStorage.setItem('fSize', fontSize)

  normalFont = ->
    changeFont(100)
  mediumFont = ->
    changeFont(115)
  largeFont  = ->
    changeFont(125)

  $('.js-font-decrease').on 'click', ->
    normalFont()

  $('.js-font-normal').on 'click', ->
    mediumFont()

  $('.js-font-increase').on 'click', ->
    largeFont()

  if sessionStorage.length != 0
    $('html').css('font-size', sessionStorage.getItem('fSize') + '%')

reset_search = ->
  $('.tt-input').val('')