class Vendedor < ActiveRecord::Base

  validates_length_of :nome, maximum: 50

  def Vendedor.to_select
    Vendedor.all.map {|c| [c.nome, c.id]}
  end

end
