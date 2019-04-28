module VendasHelper

  def flag_pagamento(venda)
    return unless venda.pendente?

    tag.span icn(:exclamation_triangle), class: 'text-danger'
  end

end
