class CreateVendedores < ActiveRecord::Migration
  def self.up
    create_table :vendedores, :force => true do |t|
      t.string :nome, :limit => 50, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :vendedores
  end
end
