module ProdutosHelper

  def label_estoque(quant)

    color = if quant == 0
              'default'
            elsif quant > 0
              'success'
            else
              'danger'
            end

    tag.span quant, class: "badge badge-#{color} badge-md"
  end

  def movimento_descr(ie)
    case ie.movimento_type
    when 'Compra'
      link_to "Compra ##{ie.movimento_id}", ie.movimento, class: 'badge badge-success badge-md'
    when 'Venda'
      link_to "Venda ##{ie.movimento_id}", ie.movimento, class: 'badge badge-danger badge-md'
    when 'Ajuste'
      cor = ie.movimento.tipo == 'E' ? 'success' : 'danger'
      link_to "Ajuste ##{ie.movimento_id}", ie.movimento, class: "badge badge-#{cor} badge-md"
    end
  end

  def label_es(es)
    case es.upcase
    when 'E'
      tag.span 'ENTRADA', class: 'badge badge-success'
    when 'S'
      tag.span 'SAÍDA', class: 'badge badge-danger'
    else
      tag.span es, class: 'badge badge-default'
    end
  end

end
