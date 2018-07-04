class AddArquivadoToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :arquivado, :boolean, default: false

    Cliente.all.each do |c|
      c.update_column :arquivado, c.vendas.blank?
    end
  end
end
