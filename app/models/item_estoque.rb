class ItemEstoque < ActiveRecord::Base

  after_create :ajusta_estoque
  after_destroy :ajusta_estoque

  belongs_to :movimento, polymorphic: true

  belongs_to :item
  delegate :barcode, :produto, :cor, :tamanho, to: :item

  validates :tipo, presence: true, inclusion: { in: ['E', 'S'] }

  scope :vendidos,  -> { where(tipo: 'S', movimento_type: 'Venda') }
  scope :comprados, -> { where(tipo: 'E', movimento_type: 'Compra') }
  scope :trocas,    -> { where(tipo: 'E', movimento_type: 'Venda') }

  scope :da_colecao,    ->(c) { joins(item: :produto).
                                   where(produtos: { colecao_id: c.id }) }

  scope :do_fornecedor, ->(f) { joins(item: :produto).
                                   where(produtos: { fornecedor_id: f.id }) }

  def set_desconto(_desconto)
    _valor = self.bruto * (1-(_desconto.to_f/100))
    update! desconto: _desconto, valor: _valor
  end

  def set_valor(_valor)
    _desconto = (1-(_valor.to_f/self.bruto)) * 100
    update! desconto: _desconto, valor: _valor
  end

  def valor_venda
    item.produto.valor
  end

  def entrada?
    tipo == 'E'
  end

  def saida?
    tipo == 'S'
  end

  private

  def ajusta_estoque
    if (entrada? && !destroyed?) || (saida? && destroyed?)
      item.increment!(:estoque)
    else
      item.decrement!(:estoque)
    end
  end

end
