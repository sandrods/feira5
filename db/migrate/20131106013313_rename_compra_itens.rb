class RenameCompraItens < ActiveRecord::Migration
  def change
    rename_table :compra_itens, :itens_compra
  end
end
