class CreateItens < ActiveRecord::Migration
  def self.up
    create_table :itens, :force => true do |t|

      t.integer :produto_id,      :null=>false
      t.integer :tamanho_id,      :null=>false
      t.integer :cor_id,          :null=>false
      
      t.integer :estoque

      t.timestamps
    end
  end

  def self.down
    drop_table :itens
  end
end
