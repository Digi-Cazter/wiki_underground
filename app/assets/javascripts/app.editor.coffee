App.Editor =
  init: ->
    return unless $('#editor').length > 0
    new SimpleMDE(
      element: document.getElementById("editor")
      autosave:
        enabled: true
        uniqueId: "WikiHive"
        deplay: 10000
    )

$(document).on "turbolinks:load", ->
  App.Editor.init()