window.App ||= {}

App.init_header = ->
  $('.dropdown').dropdown()
  $('.profile-dropdown').dropdown()

# TODO: Update this code to be more elegant for this purpose
App.init_create_resource = ->
  name_field = $('#space_name')
  slug_field = $('#space_slug')

  name_field.on 'keyup', ->
    slug_field.val(name_field.val().replace(' ', '_'))

App.init_footer = ->
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

$(document).on "turbolinks:load", ->
  App.init_header()
  App.init_create_resource()
  App.init_footer()