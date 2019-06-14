class Conta < ActiveRecord::Base

  validates_length_of :nome, maximum: 20

  has_many :registros

  def self.to_select
    Conta.order(:nome).pluck(:nome, :id)
  end

  def saldo
    registros.creditos.pagos.sum(:valor) - registros.debitos.pagos.sum(:valor)
  end

end
