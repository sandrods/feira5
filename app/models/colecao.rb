class Colecao < ActiveRecord::Base

  default_scope -> { order('id desc') }

  has_many :despesas, -> { where(cd: "D").order('data asc') },  class_name: "Registro"
  has_many :receitas, -> { where(cd: "C").order('data asc') },  class_name: "Registro"

  has_many :compras
  has_many :produtos

  def self.to_select
    Colecao.order('id desc').pluck(:descricao, :id)
  end

end
