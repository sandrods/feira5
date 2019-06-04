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

  # $(".compra_nf input[type=checkbox]").bootstrapToggle
  #   on: 'COM NF'
  #   off: 'SEM NF'
  #   width: '100px'
  #   onstyle: 'danger'
  #   offstyle: 'secondary'

  $('[data-behavior~=valor_nf]').on "click", (ev) ->
    ev.preventDefault()
    $('#compra_valor_nf').val($(ev.target).data('valor'))
