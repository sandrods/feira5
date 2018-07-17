module VendasHelper

  def flag_pagamento(venda)
    return unless (100 - (venda.total / venda.pagamentos.sum(:valor) * 100)).abs > 3

    tag.span icn(:exclamation_triangle), class: 'text-danger'
  end

end
