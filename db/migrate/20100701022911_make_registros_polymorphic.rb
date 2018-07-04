class MakeRegistrosPolymorphic < ActiveRecord::Migration
  def self.up
    add_column :registros, :registravel_id, :integer
    add_column :registros, :registravel_type, :string, :limit =>20 
  end

  def self.down
    remove_column :registros, :registravel_type
    remove_column :registros, :registravel_id
  end
end