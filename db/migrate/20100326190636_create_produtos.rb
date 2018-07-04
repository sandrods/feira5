class CreateProdutos < ActiveRecord::Migration
  def self.up
    create_table :produtos, :force => true do |t|

      t.string  :ref,             :limit=>30

      t.integer :colecao_id,      :null=>false
      t.integer :tipo_id,         :null=>false
      t.integer :linha_id,        :null=>false
      t.integer :fornecedor_id,   :null=>false

      t.decimal :custo,           :scale=>2, :precision=>9,   :null=>false
      t.decimal :valor,           :scale=>2, :precision=>9,   :null=>false

      t.boolean :ativo,           :default=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :produtos
  end
end
