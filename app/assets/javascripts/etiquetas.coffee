# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.DeleteRow = (tr) ->
    row = $(tr).children('td')
    	      .css(backgroundColor: "#c82333", color: "white")

    del = () =>
            $(row)
            .animate({ paddingTop: 0, paddingBottom: 0 }, 500)
            .wrapInner('<div />')
            .children()
            .slideUp(200, () -> $(this).closest('tr').remove() )

    setTimeout del, 500

document.addEventListener "turbolinks:load", ->

  $('#add_etiqueta').on 'click', (e) ->
    e.preventDefault()
    $('#add_etiqueta_form').slideDown()
    $('#add_etiqueta').fadeOut(300, () -> $('#end_add_etiqueta').show() )


  $('#end_add_etiqueta').on 'click', (e) ->
    e.preventDefault()
    $('#add_etiqueta_form').slideUp()
    $('#end_add_etiqueta').fadeOut(300, () -> $('#add_etiqueta').show() )
