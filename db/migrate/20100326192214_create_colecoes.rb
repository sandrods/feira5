class CreateColecoes < ActiveRecord::Migration
  def self.up
    create_table :colecoes, :force => true do |t|
      t.string :descricao, :limit => 30, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :colecoes
  end
end
