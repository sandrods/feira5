class RenameEstoques < ActiveRecord::Migration
  def self.up
    rename_table :estoques, :estoque_itens
  end

  def self.down
    rename_table :estoque_itens, :estoques
  end
end