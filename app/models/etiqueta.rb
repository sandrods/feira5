class Etiqueta < ActiveRecord::Base
  belongs_to :cor
  belongs_to :tamanho
  belongs_to :produto

  delegate :ref, :fornecedor, :colecao, to: :produto

  validates :cor_id, :tamanho_id, :produto_id, presence: true

  scope :selecionadas, -> { where.not(mark: nil).order(:mark)  }
  scope :nao_selecionadas, -> { where(mark: nil) }

  scope :geradas,   -> { where(gerada: true) }
  scope :pendentes, -> { where(gerada: false) }

  def sub1
    "#{cor.nome} - #{tamanho.nome}"
  end

  def sub2
    "#{ref} #{cor.nome} #{tamanho.nome}"
  end

  def barcode
    "#{cor_id.to_s.rjust(2, '0')}#{tamanho_id.to_s.rjust(2, '0')}#{produto_id.to_s.rjust(6, '0')}"
  end

  def valor
    ActionController::Base.helpers.number_to_currency produto.valor
  end

  def selecionada?
    mark.present?
  end

  def mark!
    update_column :mark, Time.now
  end

  def unmark!
    update_column :mark, nil
  end

  def self.geradas!
    Etiqueta.selecionadas.update_all gerada: true
  end

end
