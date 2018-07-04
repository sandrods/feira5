class CreateEtiquetas < ActiveRecord::Migration
  def self.up
    create_table :etiquetas do |t|
      t.integer :produto_id
      t.integer :tamanho_id
      t.integer :cor_id

    end
  end

  def self.down
    drop_table :etiquetas
  end
end
