class Sacola < ActiveRecord::Base
  include ClienteOuVendedor

  has_many :itens, class_name: "ItemSacola", dependent: :destroy

  def adiciona_item!(bc)
    ItemSacola.from_barcode(bc, self)
  end

  def total
    itens.incluidos.to_a.sum { |i| i.item.try(:produto).try(:valor) }
  end

end
