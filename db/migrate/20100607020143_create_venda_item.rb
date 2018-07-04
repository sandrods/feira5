class CreateVendaItem < ActiveRecord::Migration
  def self.up
    create_table :venda_itens, :force => true do |t|
      t.references :venda,    :null => false
      t.references :item,     :null => false

      t.decimal      :bruto,    :scale=>2, :precision=>9
      t.decimal      :desconto, :scale=>2, :precision=>4
      t.decimal      :valor,    :scale=>2, :precision=>9

      t.timestamps
    end

    add_index :venda_itens, :venda_id
    add_index :venda_itens, :item_id
  end

  def self.down
    drop_table :venda_itens
  end
end
