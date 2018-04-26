# coding: utf-8
class ItemSacola < ActiveRecord::Base

  belongs_to :sacola
  belongs_to :item

  delegate :barcode, :produto, :cor, :tamanho, to: :item

  scope :incluidos,  -> { where(status: 'I') }
  scope :devolvidos, -> { where(status: 'D') }

  def self.from_barcode(bc, sacola)

    item = Item.find_by_barcode!(bc)

    sacola.itens.create!(item_id: item.id, status: 'I')

  end

  def self.devolve(bc, sacola_id)

    item = Item.find_by_barcode!(bc)

    sacola = Sacola.find(sacola_id)

    item_sacola = sacola.itens.find_by(item_id: item.id, status: 'I')

    if item_sacola.nil?

      item_sacola = sacola.itens.find_by(item_id: item.id, status: 'D')
      if item_sacola.nil?
        raise ItemException.new("Esta peça NÃO pertence a esta Sacola")
      else
        raise ItemException.new("Esta peça já foi devolvida")
      end

    end

    item_sacola.update! status: 'D'

    item_sacola
  end

  def valor
    produto && produto.valor
  end

end
