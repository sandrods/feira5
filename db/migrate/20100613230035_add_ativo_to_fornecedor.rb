class AddAtivoToFornecedor < ActiveRecord::Migration
  def self.up
    add_column :fornecedores, :ativo, :boolean, :default => true
  end

  def self.down
    remove_column :fornecedores, :ativo
  end
end