class Tipo < ActiveRecord::Base

  has_many :produtos, dependent: :restrict_with_error

  default_scope -> { order(:descricao) }

  def self.to_select
    Tipo.order(:descricao).pluck(:descricao, :id)
  end

end
