window.show_item_exception = (msg) ->
  $("#fail_sound")[0].play();
  $("#error_msg").html(msg);
  $("#error_modal").modal();

window.show_item_box = (data) ->
  $("#sound")[0].play()

  $("#item_modal .modal-title").html(data.title)

  $("#modal_ref").html(data.ref)
  $("#modal_cor").html(data.cor)
  $("#modal_tam").html(data.tam)

  $("#item_modal").modal()

  bc = if data.focus? then data.focus else $('.bar-code-input')

  setTimeout () ->
    $("#item_modal").modal('hide')
    bc.focus()
  , 3000