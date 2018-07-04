class RenameVendaItens < ActiveRecord::Migration
  def change
    rename_table :venda_itens, :itens_venda
  end
end
