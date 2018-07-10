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
      @itens = ItemEstoque.da_colecao(colecao)
    end

    def itens_vendidos
      @iv ||= @itens.vendidos
    end

    def itens_comprados
      @ic ||= @itens.comprados
    end

    def quantidade_vendidos
      @qv ||= itens_vendidos.count
    end

    def quantidade_comprados
      @qc ||= itens_comprados.count
    end

    def porcent_vendidos
      (quantidade_vendidos.to_f / quantidade_comprados * 100).to_i rescue 0
    end

    def valor_despesas
      @vd ||= itens_comprados.sum(:valor) + @colecao.despesas.sum(:valor)
    end

    def valor_receitas
      @vr ||= itens_vendidos.sum(:valor) + @colecao.receitas.sum(:valor)
    end

    def valor_estoque
      @ve ||= (itens_comprados - itens_vendidos).sum(&:valor_venda)
    end

    def porcent_receitas
      (valor_receitas.to_f / valor_despesas * 100).to_i rescue 0
    end

    def despesas
      @despesas ||= begin
        desp = []

        itens_comprados.group_by(&:movimento).each do |compra, itens|
          total = itens.sum(&:valor)
          txt = "Compra #{itens[0].produto.fornecedor.nome} <small>##{compra.id}</small>".html_safe
          desp << Line.new(txt, total, compra.data)
        end

        @colecao.despesas.each do |c|
          desp << Line.new(c.descricao, c.valor, c.data)
        end

        desp.sort_by(&:data)
      end
    end

    def vendas_por_tipo
      itens_vendidos
        .group_by { |it| it.item.produto.tipo }
        .map      { |tipo, itens| PorTipo.new(tipo.descricao, itens.size) }
        .sort_by  { |i| i.quant }
        .reverse
    end

  end

  class Fornecedor

    attr_accessor :fornecedor

    def self.por(colecao)
      fornecedores = ItemEstoque.da_colecao(colecao)
                                .map { |ie| ie.item.produto.fornecedor }
                                .uniq

      fornecedores.map { |f| Fornecedor.new(colecao, f) }
    end

    def initialize(colecao, fornecedor)
      @fornecedor = fornecedor
      @itens = ItemEstoque.da_colecao(colecao)
                          .do_fornecedor(fornecedor)
    end

    def itens_vendidos
      @iv ||= @itens.vendidos
    end

    def itens_comprados
      @ic ||= @itens.comprados
    end

    def quantidade_vendidos
      @qv ||= itens_vendidos.count
    end

    def quantidade_comprados
      @qc ||= itens_comprados.count
    end

    def valor_despesas
      @vd ||= itens_comprados.sum(:valor)
    end

    def valor_receitas
      @vr ||= itens_vendidos.sum(:valor)
    end

    def valor_estoque
      @ve ||= (itens_comprados - itens_vendidos).sum(&:valor_venda)
    end

    def porcent_vendidos
      (quantidade_vendidos.to_f / quantidade_comprados * 100).to_i rescue 0
    end

    def porcent_receitas
      (valor_receitas.to_f / valor_despesas * 100).to_i rescue 0
    end

    def vendas_por_tipo
      itens_vendidos
        .group_by { |it| it.item.produto.tipo }
        .map      { |tipo, itens| PorTipo.new(tipo.descricao, itens.size) }
        .sort_by  { |i| i.quant }
        .reverse
    end

  end

  PorTipo = Struct.new(:tipo, :quant)

end
