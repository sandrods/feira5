class Fornecedor < ActiveRecord::Base
  include Arquivar

  default_scope -> { order(:nome) }

  has_many :compras

  ESTADOS = %w(RS SP AC AL AM AP BA CE DF ES GO MA MG MS MT PA PB PE PI PR RJ RN RO RR SC SE TO)

  def self.to_select
    Fornecedor.ativos.pluck(:nome, :id)
  end

end
