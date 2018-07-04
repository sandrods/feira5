class AddIndices < ActiveRecord::Migration
  def self.up

    add_index :itens, :produto_id
    add_index :itens, :tamanho_id
    add_index :itens, :cor_id

    add_index :compra_itens, :compra_id
    add_index :compra_itens, :item_id

    add_index :produtos, :colecao_id
    add_index :produtos, :tipo_id    
    add_index :produtos, :linha_id
    add_index :produtos, :fornecedor_id

  end

  def self.down
  end
end
