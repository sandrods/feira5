class Cor < ActiveRecord::Base

  has_many :itens, dependent: :restrict_with_error

  default_scope -> { order(:nome) }

  def Cor.to_select
    @@combo ||= Cor.update_select
  end

  def Cor.update_select
    @@combo = Cor.all.map {|c| [c.nome, c.id]}
  end

end
