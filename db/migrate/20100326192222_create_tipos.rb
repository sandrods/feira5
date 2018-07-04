class CreateTipos < ActiveRecord::Migration
  def self.up
    create_table :tipos, :force => true do |t|
      t.string :descricao, :limit => 30, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tipos
  end
end
