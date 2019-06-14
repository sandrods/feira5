class Linha < ActiveRecord::Base

  default_scope -> { order(:descricao) }

  def self.to_select
    Linha.order(:descricao).pluck(:descricao, :id)
  end

end
