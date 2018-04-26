class Compra < ActiveRecord::Base

# acts_as_br_date :data
# acts_as_br_float :desconto

  belongs_to :fornecedor
  belongs_to :colecao

  #has_many :itens, class_name: 'ItemCompra', dependent: :destroy
  has_many :itens, -> { where(tipo: 'E') }, class_name: 'ItemEstoque', as: :movimento, dependent: :destroy

  has_many :pagamentos, -> { where(cd: 'D').order('data') }, class_name: "Registro", as: :registravel

  def adiciona_item!(bc)

    item = Item.find_or_create_by_barcode(bc)

    if self.fornecedor_id != item.produto.fornecedor_id
      raise ItemException.new("Fornecedor do Produto diferente do Fornecedor da Compra - #{item.produto.try(:fornecedor).try(:nome)}")
    end

    # valor = (compra.desconto && compra.desconto > 0) ? item.produto.custo * (1-(compra.desconto/100)) : item.produto.custo

    itens.create!(item_id: item.id, valor: item.produto.custo)

  end

  def total
    tot = itens.sum(:valor)
    tot = tot * (1 - desconto / 100) if desconto?
    tot
  end

  def desconto?
    desconto.present? && desconto > 0
  end


end
