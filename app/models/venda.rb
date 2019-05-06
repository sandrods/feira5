class Venda < ActiveRecord::Base
  include ClienteOuVendedor

  has_many :itens,  -> { where(tipo: 'S') }, class_name: 'ItemEstoque', as: :movimento, dependent: :destroy
  has_many :trocas, -> { where(tipo: 'E') }, class_name: 'ItemEstoque', as: :movimento, dependent: :destroy

  has_many :pagamentos, -> { where(cd: "C").order('data asc') },  class_name: "Registro", as: :registravel

  def self.from_sacola(sacola_id)
    sacola = Sacola.find(sacola_id)

    venda = Venda.create!(data: Date.today, cliente_id: sacola.cliente_id, tipo: sacola.tipo)

    sacola.itens.incluidos.each do |item_sacola|
      item = item_sacola.item
      venda.itens.create!(item_id: item.id, valor: item.produto.valor, desconto: 0, bruto: item.produto.valor)
    end

    venda
  end

  def adiciona_item!(bc)
    item = Item.find_by_barcode!(bc)

    itens.create!(item_id: item.id, bruto: item.produto.valor, desconto: 0, valor: item.produto.valor)
  end

  def adiciona_troca!(bc)
    item = Item.find_by_barcode!(bc)

    troca = ItemEstoque
              .vendidos
              .where(movimento_id: outras_vendas.pluck(:id))
              .find_by(item_id: item.id)

    if troca
      trocas.create!(item_id: item.id, bruto: troca.bruto, desconto: troca.desconto, valor: troca.valor)
    else
      trocas.create!(item_id: item.id, bruto: item.produto.valor, desconto: 0, valor: 0)
    end

  end

  def total
    t = itens.sum(:valor)
    return t unless desconto?

    t * (1 - (desconto / 100)).to_f
  end

  def total_pagamentos
    trocas.sum(:valor) + pagamentos.sum(:valor)
  end

  def saldo
    total_pagamentos - total 
  end

  def desconto?
    desconto.present? && desconto > 0
  end

  def descr
    "Venda ##{id}"
  end

  def pendente?
    total_pagamentos = pagamentos.sum(:valor) + trocas.sum(:valor)

    (100 - (total / total_pagamentos * 100)).abs > 3

  end

end
