class Produto < ActiveRecord::Base

  belongs_to :linha
  belongs_to :tipo
  belongs_to :colecao
  belongs_to :fornecedor

  has_many :itens, dependent: :destroy
  has_many :etiquetas, dependent: :destroy

  has_many :itens_estoque, through: :itens

  before_save :calcula_lucro

  validates :colecao_id, :linha_id, :fornecedor_id, :tipo_id, :ref, :valor, presence: true

  # acts_as_br_currency :custo, :valor

  def Produto.rentabilidade(_valor, _custo)
    return 0 if _custo == 0
    ((_valor/_custo) - 1) * 100 rescue nil
  end

  def Produto.lucro(valor1, custo1)
    valor1-custo1 rescue nil
  end

  def movimentacoes
    itens_estoque.sort_by { |m| m.movimento.data }
  end

  def descricao
    "#{tipo.descricao} #{ref} #{fornecedor.nome}"
  end

  def ref1
    ref =~ /\S+\s+(\S+)\s+\S+/ ? $1 : ref
  end

  private

  def calcula_lucro
    self.lucro = Produto.lucro(self.valor, self.custo)
    self.rentabilidade = Produto.rentabilidade(self.valor, self.custo)
  end

end
