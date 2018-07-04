class CreateSacolaItens < ActiveRecord::Migration
  def self.up
    create_table :sacola_itens do |t|
      t.integer :sacola_id, :null => false
      t.integer :item_id,   :null => false
      t.string :status,     :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :sacola_itens
  end
end
