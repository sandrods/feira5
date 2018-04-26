class Linha < ActiveRecord::Base

  default_scope -> { order(:descricao) }
  
  def Linha.to_select
    @@combo ||= Linha.update_select
  end
  
  def Linha.update_select
    @@combo = Linha.all.map {|c| [c.descricao, c.id]}
  end

end
