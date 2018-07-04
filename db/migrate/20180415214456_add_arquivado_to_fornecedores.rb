class AddArquivadoToFornecedores < ActiveRecord::Migration
  def change
    remove_column :fornecedores, :ativo
    add_column    :fornecedores, :arquivado, :boolean, default: false
  end
end
