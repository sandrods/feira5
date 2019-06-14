class Vendedor < ActiveRecord::Base

  validates_length_of :nome, maximum: 50

  def self.to_select
    Vendedor.order(:nome).pluck(:nome, :id)
  end

end
