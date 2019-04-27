module ClienteOuVendedor
  extend ActiveSupport::Concern

  included do

    belongs_to :cliente, optional: true
    belongs_to :vendedor, optional: true

    validates_presence_of :cliente_id,  if: ->(v) { v.vendedor_id.blank? }
    validates_presence_of :vendedor_id, if: ->(v) { v.cliente_id.blank? }

    scope :clientes,      -> { where(tipo: "C" ) }
    scope :comissionadas, -> { where(tipo: "V" ) }

  end

  def cliente?
    tipo == 'C'
  end

  def nome
    cliente? ?
      cliente.try(:nome) :
      vendedor.try(:nome)
  end

  def outras_vendas
    outras = Venda.where.not(id: id)

    if cliente_id.present?
      outras.where(cliente_id: cliente_id)
    else
      outras.where(vendedor_id: vendedor_id)
    end
  end

end
