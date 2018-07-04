class CreateTamanhos < ActiveRecord::Migration
  def self.up
    create_table :tamanhos, :force => true do |t|
      t.string :nome, :limit => 10, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tamanhos
  end
end
