class Cliente < ActiveRecord::Base
  include Arquivar

  has_many :vendas, dependent: :restrict_with_error

  scope :por_letra, -> (letra) { where(["nome like ?", "#{letra}%"]) }
  default_scope -> { order(:nome) }

  validates :nome, length: { maximum: 60 }, presence: true

  validate :data_aniversario

  { email:     40,
    fone_res:  20,
    fone_com:  20,
    fone_cel:  20,
    endereco:  60,
    bairro:    30,
    cep:       10,
    cidade:    60,
    uf:        2,
    obs:       100
  }.each do |key, val|
    validates key, length: { maximum: val },  allow_blank: true
  end

  def fone
    fone_cel || fone_res || fone_com
  end

  def aniversario
    unless aniver_dia.blank? || aniver_mes.blank?
      "#{aniver_dia.to_s.rjust(2, '0')}/#{aniver_mes.to_s.rjust(2, '0')}"
    end
  end

  def aniversario=(aniver)
    a = aniver.split("/")
    write_attribute(:aniver_dia, a[0])
    write_attribute(:aniver_mes, a[1])
  end


  def self.letras
    Cliente.all.map {|c| c.nome.try(:first).try(:upcase) }.uniq.sort
  end

private

  def data_aniversario
    errors.add(:aniversario, "Data Inválida") if aniver_dia.blank? != aniver_mes.blank?
    unless aniver_dia.blank? && aniver_mes.blank?
      dt = Date.new(2001, aniver_mes.to_i, aniver_dia.to_i) rescue nil
      errors.add(:aniversario, 'Data Inválida') unless dt
    end
  end

end
