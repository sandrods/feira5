module ClienteOuVendedor
  extend ActiveSupport::Concern

  included do

    belongs_to :cliente
    belongs_to :vendedor

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

end
