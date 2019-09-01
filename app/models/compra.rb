class Compra < ActiveRecord::Base

# acts_as_br_date :data
# acts_as_br_float :desconto

  belongs_to :fornecedor
  belongs_to :colecao

  #has_many :itens, class_name: 'ItemCompra', dependent: :destroy
  has_many :itens, -> { where(tipo: 'E').joins(item: :produto).order('produtos.tipo_id, produtos.ref') }, class_name: 'ItemEstoque', as: :movimento, dependent: :destroy
  has_many :trocas, -> { where(tipo: 'S').joins(item: :produto).order('produtos.tipo_id, produtos.ref') }, class_name: 'ItemEstoque', as: :movimento, dependent: :destroy

  has_many :pagamentos, -> { where(cd: 'D').order('data') }, class_name: "Registro", as: :registravel

  validates :data, presence: true

  def adiciona_item!(bc)

    item = Item.find_or_create_by_barcode(bc)

    if self.fornecedor_id != item.produto.fornecedor_id
      raise ItemException.new("Fornecedor do Produto diferente do Fornecedor da Compra - #{item.produto.try(:fornecedor).try(:nome)}")
    end

    # valor = (compra.desconto && compra.desconto > 0) ? item.produto.custo * (1-(compra.desconto/100)) : item.produto.custo

    itens.create!(item_id: item.id, valor: item.produto.custo)

  end

  def adiciona_troca!(bc)
    item = Item.find_by_barcode!(bc)

    if self.fornecedor_id != item.produto.fornecedor_id
      raise ItemException.new("Fornecedor do Produto diferente do Fornecedor da Compra - #{item.produto.try(:fornecedor).try(:nome)}")
    end

    troca = ItemEstoque
              .comprados
              .where(movimento_id: outras_compras.pluck(:id))
              .find_by(item_id: item.id)

    if troca
      trocas.create!(item_id: item.id, valor: troca.valor)
    else
      trocas.create!(item_id: item.id, valor: item.produto.custo)
    end

  end

  def total
    tot = itens.sum(:valor)
    tot = tot * (1 - desconto / 100) if desconto?
    tot
  end

  def total_pagamentos
    trocas.sum(:valor) + pagamentos.sum(:valor)
  end

  def saldo
    total_pagamentos - total
  end

  def desconto?
    desconto.present? && desconto.nonzero?
  end

  def com_nf?
    valor_nf.present? && valor_nf.nonzero?
  end

  def pendente?
    total_pagamentos = pagamentos.sum(:valor) + trocas.sum(:valor)

    (100 - (total / total_pagamentos * 100)).abs > 3

  end
  
  private

  def outras_compras
    Compra
      .where.not(id: id)
      .where(fornecedor_id: fornecedor_id)
  end

end
