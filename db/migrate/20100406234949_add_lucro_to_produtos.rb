class AddLucroToProdutos < ActiveRecord::Migration
  def self.up
    add_column :produtos, :lucro,         :decimal, :scale=>2, :precision=>9
    add_column :produtos, :rentabilidade, :decimal, :scale=>2, :precision=>9

    Produto.all.each { |p| p.save }

  end

  def self.down
    remove_column :produtos, :rentabilidade
    remove_column :produtos, :lucro
  end
end
