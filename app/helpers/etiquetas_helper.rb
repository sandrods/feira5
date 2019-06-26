module EtiquetasHelper

  def link_mark(etiqueta)
    if etiqueta.selecionada?
      link_to icn(:minus_sign),
              unselect_etiqueta_path(etiqueta),
              remote: true,
              method: 'POST',
              class: 'btn text-danger'
    else
      link_to icn(:chevron_right, 'add', false),
              select_etiqueta_path(etiqueta),
              remote: true,
              method: 'POST',
              class: 'btn btn-sm btn-success'
    end
  end

  def nbsp(num = 20)
    ("&nbsp;" * num).html_safe
  end
end
