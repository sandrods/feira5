class CreateCores < ActiveRecord::Migration
  def self.up
    create_table :cores, :force => true do |t|
      t.string :nome, :limit => 20, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :cores
  end
end
