class Colecao::Resultado

  attr_accessor :total, :por_fornecedor

  def initialize(colecao)
    @colecao = colecao
    @total = Total.new(@colecao)
    @por_fornecedor = Fornecedor.por(@colecao)
  end

  class Total

    Line = Struct.new(:descr, :valor, :data)

    def initialize(colecao)
      @colecao = colecao
    end

    def itens_vendidos
      @iv ||= ItemEstoque
                .vendidos
                .joins(item: :produto)
                .where(produtos: { colecao_id: @colecao.id })
    end

    def quantidade_vendidos
      @qv ||= itens_vendidos.count
    end

    def quantidade_comprados
      @qc ||= @colecao.compras.to_a.sum { |c| c.itens.count }
    end

    def porcent_vendidos
      (quantidade_vendidos.to_f / quantidade_comprados * 100).to_i rescue 0
    end

    def valor_despesas
      @vd ||= @colecao.compras.to_a.sum(&:total) + @colecao.despesas.sum(:valor)
    end

    def valor_receitas
      @vr ||= itens_vendidos.sum(:valor) + @colecao.receitas.sum(:valor)
    end

    def porcent_receitas
      (valor_receitas.to_f / valor_despesas * 100).to_i rescue 0
    end

    def despesas
      @despesas ||= begin
        desp = []

        @colecao.compras.each do |c|
          desp << Line.new("Compra #{c.fornecedor.nome}", c.total, c.data)
        end

        @colecao.despesas.each do |c|
          desp << Line.new(c.descricao, c.valor, c.data)
        end

        desp
      end
    end

  end

  class Fornecedor

    PorTipo = Struct.new(:tipo, :quant)

    attr_accessor :fornecedor

    def self.por(colecao)
      fornecedores = colecao.compras.map(&:fornecedor).uniq
      fornecedores.map { |f| Fornecedor.new(colecao, f) }
    end

    def initialize(colecao, fornecedor)
      @colecao = colecao
      @fornecedor = fornecedor

      @compras = @colecao.compras.where(fornecedor_id: @fornecedor.id)
    end

    def itens_vendidos
      @iv ||= ItemEstoque.vendidos.joins(item: :produto)
                                  .where(produtos:
                                            { colecao_id: @colecao.id,
                                              fornecedor_id: @fornecedor.id })
    end

    def quantidade_vendidos
      @qv ||= itens_vendidos.count
    end

    def quantidade_comprados
      @qc ||= @compras.to_a.sum { |c| c.itens.count }
    end

    def porcent_vendidos
      (quantidade_vendidos.to_f / quantidade_comprados * 100).to_i rescue 0
    end

    def vendas_por_tipo
      itens_vendidos
        .group_by { |it| it.item.produto.tipo }
        .map      { |tipo, itens| PorTipo.new(tipo.descricao, itens.size) }
        .sort_by  { |i| i.quant }
        .reverse
    end

  end

end
