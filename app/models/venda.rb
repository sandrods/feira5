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

    liquido = (self.desconto?) ? item.produto.valor * (1-(self.desconto/100)) : item.produto.valor

    self.itens.create!(item_id: item.id, bruto: item.produto.valor, desconto: (desconto || 0), valor: liquido)

    #self.itens.create!(item_id: item.id, valor: item.produto.valor)

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
    itens.sum(:valor)
  end

  def desconto?
    desconto.present? && desconto > 0
  end

  def descr
    "Venda ##{id}"
  end

end
