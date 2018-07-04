class AddDescontoToVenda < ActiveRecord::Migration
  def self.up  
    add_column :vendas, :desconto, :decimal, :precision => 9, :scale => 2
  end

  def self.down
    remove_column :vendas, :desconto
  end
end