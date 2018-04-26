class Ajuste < ActiveRecord::Base

  has_many :itens, class_name: 'ItemEstoque', as: :movimento, dependent: :destroy

  validates :tipo, presence: true, inclusion: { in: ['E', 'S'] }

  def adiciona_item!(bc)

    item = Item.find_or_create_by_barcode(bc)

    itens.create!(item_id: item.id, tipo: self.tipo)

  end

  def data
    created_at.to_date
  end

end
