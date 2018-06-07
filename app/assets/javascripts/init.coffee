document.addEventListener "turbolinks:before-cache", ->
  $('select').not('.custom_select').select2 "destroy"

$(document).on "hidden.bs.modal", "#global_modal", (e) ->
    $(e.target).removeData("bs.modal").find(".modal-content").empty()

$(document).on "click", '[data-behavior~=load-modal]', (ev) ->
    ev.preventDefault()
    url = this.getAttribute('href') || this.getAttribute('data-url')

    if size = this.getAttribute('data-modal-size')
      $("#global_modal .modal-dialog").addClass("modal-#{size}")

    $("#global_modal .modal-content").load url, App.modals

    $('#global_modal').modal('show')


window.App ||= {}

App.init = ->

  $(".datepicker").each () ->
    max = !!this.getAttribute('data-no-future')
    min = !!this.getAttribute('data-no-past')

    $(this).pickadate
      hiddenName: true
      format: 'dd/mm/yyyy'
      formatSubmit: 'dd/mm/yyyy'
      min: min
      max: max

  $("[data-mask]").each () ->
    _mask = this.getAttribute('data-mask')

    $(this).mask _mask, autoclear: false

  $(".currency").maskMoney()
  $(".percentage").maskMoney(precision: 0)

  $('.simple_form .clear').on 'click', (e) ->
    e.preventDefault()

    for input in $('.simple_form input[type=text]')
      $(input).val('')

    for select_found in $('.simple_form select')
      $(select_found).not('.custom_select').val('').trigger("change")

    for select_found in $('.custom_select')
      $(select_found).val([])

  App.select2.init()

App.modals = ->
  App.init()
  # App.dependentes.init()
  # adicione aqui codigo para ser executado em modais

document.addEventListener "turbolinks:load", ->
  App.init()


# rodar js baseado em controller#action
# exemplo: return unless in_action('login#index')
window.in_action = (act) ->
  $('[data-action]').first().data('action') == act
