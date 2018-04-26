class ItemEstoque < ActiveRecord::Base

  after_create :ajusta_estoque
  after_destroy :ajusta_estoque

  belongs_to :movimento, polymorphic: true

  belongs_to :item
  delegate :barcode, :produto, :cor, :tamanho, to: :item

  validates :tipo, presence: true, inclusion: { in: ['E', 'S'] }

  scope :vendidos, -> { where(tipo: 'S', movimento_type: 'Venda') }

  def set_desconto(_desconto)
    _valor = self.bruto * (1-(_desconto.to_f/100))
    update! desconto: _desconto, valor: _valor
  end

  def set_valor(_valor)
    _desconto = (1-(_valor.to_f/self.bruto)) * 100
    update! desconto: _desconto, valor: _valor
  end

  private

  def ajusta_estoque
    if (tipo == 'E' && !destroyed?) || (tipo == 'S' && destroyed?)
      item.increment!(:estoque)
    else
      item.decrement!(:estoque)
    end
  end

end
