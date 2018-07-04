class CreateVenda < ActiveRecord::Migration
  def self.up
    create_table :vendas, :force => true do |t|
      t.references :cliente
      t.references :vendedor

      t.date     :data
      t.string   :tipo,  :limit => 1
      t.decimal  :valor, :scale=>2, :precision=>9
      t.string   :obs,   :limit => 100

      t.timestamps
    end

    add_index :vendas, :cliente_id
    add_index :vendas, :vendedor_id

  end

  def self.down
    drop_table :vendas
  end
end
