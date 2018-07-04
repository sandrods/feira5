class CreateSacolas < ActiveRecord::Migration
  def self.up
    create_table :sacolas, :force => true do |t|

      t.integer :vendedor_id, :null => false
      t.string :status,       :limit =>1
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sacolas
  end
end
