class CreateContas < ActiveRecord::Migration
  def self.up
    create_table :contas, :force => true do |t|
      t.string :nome, :limit => 30, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contas
  end
end
