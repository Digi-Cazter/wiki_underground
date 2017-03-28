App.Search =
  init: ->
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

    App.Search.typeahead_search = $('.typeahead-search').typeahead({ highlight: true, minLength: 1 }, {
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

    App.Search.typeahead_search.on 'keydown', ->
      clearTimeout(window.search_animation_timer)
      if $('#hive-loader').hasClass('animate') == false
        $('#hive-loader').addClass('animate')

    App.Search.typeahead_search.on 'keyup', ->
      window.search_animation_timer = setTimeout ->
        $('#hive-loader').removeClass('animate')
      , 1000

    App.Search.typeahead_search.on 'typeahead:selected', (obj, datum) ->
      switch datum
        when "Create new Space"
          $('#create_space').modal('show');
        when "Create new Page"
          $('#create_page').modal('show');
      $(this).typeahead("val", "")
      return

  reset_search: ->
    $('.tt-input').val('')

$(document).on "turbolinks:load", ->
  App.Search.init()