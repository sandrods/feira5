class CreateCompras < ActiveRecord::Migration
  def self.up
    create_table :compras, :force => true do |t|

      t.integer :fornecedor_id,   :null=>false
      t.date    :data
      t.decimal :valor,           :scale=>2, :precision=>9

      t.timestamps
    end
  end

  def self.down
    drop_table :compras
  end
end
