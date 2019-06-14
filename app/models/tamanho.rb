class Tamanho < ActiveRecord::Base

  has_many :itens, dependent: :restrict_with_error

  default_scope -> { order('nome') }

  def self.to_select
    Tamanho.order(:id).pluck(:nome, :id)
  end

end
