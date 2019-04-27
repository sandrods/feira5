module VendasHelper

  def flag_pagamento(venda)
    total_pagamentos = venda.pagamentos.sum(:valor) + venda.trocas.sum(:valor)
    return unless (100 - (venda.total / total_pagamentos * 100)).abs > 3

    tag.span icn(:exclamation_triangle), class: 'text-danger'
  end

end
