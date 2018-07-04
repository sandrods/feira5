class AddDescontoToCompra < ActiveRecord::Migration
  def self.up
    add_column :compras, :desconto, :decimal, :precision => 9, :scale => 2
  end

  def self.down
    remove_column :compras, :desconto
  end
end
