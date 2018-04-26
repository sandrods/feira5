class Venda::Mensal

  attr_accessor :calendar

  def initialize(data)
    @calendar = Calendar.new(date: data)
    @vendas = Venda.where(data: @calendar.range)
    @itens = ItemEstoque.vendidos.where(movimento_id: @vendas.pluck(:id))
  end

  def total_pecas
    @tp ||= @itens.count
  end

  def total_valor
    @tv ||= @itens.sum(:valor)
  end

  def valor_medio
    total_pecas > 0 ? total_valor / total_pecas : 0
  end

  def por_fornecedor
    @itens.joins(item: { produto: :fornecedor }).group('fornecedores.nome').order('count_all desc').count
  end

  def por_tipo
    @itens.joins(item: { produto: :tipo }).group('tipos.descricao').order('count_all desc').count
  end

  def por_colecao
    @itens.joins(item: { produto: :colecao }).group('colecoes.descricao').order('count_all desc').count
  end

end
