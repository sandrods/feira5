class Tamanho < ActiveRecord::Base

  has_many :itens, dependent: :restrict_with_error

  default_scope -> { order('nome') }

  def Tamanho.to_select
    @@combo ||= Tamanho.all.map {|c| [c.nome, c.id]}
  end

end
