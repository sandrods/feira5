class RenameEstoqueItens < ActiveRecord::Migration
  def self.up
    rename_table :estoque_itens, :compra_itens
  end

  def self.down
    rename_table :compra_itens, :estoque_itens
  end
end