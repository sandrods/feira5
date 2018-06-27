class Registro < ActiveRecord::Base

  before_create :registrar_conta_forma_pagamento
  before_create :registrar_pagamento

  # acts_as_br_date :data
  # acts_as_br_currency :valor

  validates_presence_of :data, :descricao, :valor, :cd

  scope :creditos, -> { where(cd: 'C') }
  scope :debitos,  -> { where(cd: 'D') }
  scope :efetivos, -> { where(transf_id: nil) }
  scope :por_data, -> { order(:data) }

  scope :pendentes,  -> { where(pago: false) }
  scope :pagos,      -> { where(pago: true) }

  scope :da_conta, ->(conta) { where(conta_id: conta) }

  belongs_to :conta, optional: true
  belongs_to :registravel, optional: true, polymorphic: true
  belongs_to :categoria, optional: true
  belongs_to :forma, optional: true
  belongs_to :colecao, optional: true

  def pendente?
    !pago
  end

  def vencido?
    data.past? && pendente?
  end

  def self.a_pagar
    debitos.pendentes.por_data
  end

  def self.a_receber
    creditos.pendentes.por_data
  end

  def valor_cd
    valor * (cd=="D" ? -1 : 1)
  end

  def receita?
    cd.upcase == 'C'
  end

  def despesa?
    !receita?
  end

  def transferencia?
    transf_id.present?
  end

  def duplicate!
    reg = self.dup

    reg.data = self.data + 1.month
    reg.pago = false

    reg.tap { |r| r.save! }
  end

  def month
    data.beginning_of_month
  end

private

  def registrar_pagamento
    # registro já nasce conciliado se não for criado em data futura
    self.pago = true if data <= Date.today
  end

  def registrar_conta_forma_pagamento
    return unless forma && forma.conta

    self.conta_id = forma.conta_id
  end

end
