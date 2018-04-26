module Arquivar
  extend ActiveSupport::Concern

  included do
    scope :ativos, -> { where(arquivado: false) }
  end

  def arquivado?
    arquivado
  end

  def arquivar!(_arquivar = true)
    update! arquivado: _arquivar
  end

end
