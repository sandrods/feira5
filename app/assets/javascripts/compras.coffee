# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->

  $('#add_pag').on 'click', (e) ->
    e.preventDefault()
    $('#add_pag_form').slideDown()
    $('#add_pag').fadeOut(300, () -> $('#end_add_pag').show() )


  $('#end_add_pag').on 'click', (e) ->
    e.preventDefault()
    $('#add_pag_form').slideUp()
    $('#end_add_pag').fadeOut(300, () -> $('#add_pag').show() )
