class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :clientes, :force => true do |t|
      t.string  :nome,     :limit => 60
      t.string  :email,    :limit => 40
      t.string  :fone_res, :limit => 20
      t.string  :fone_com, :limit => 20
      t.string  :fone_cel, :limit => 20
      t.string  :endereco, :limit => 60
      t.string  :bairro,   :limit => 30
      t.string  :cep,      :limit => 10
      t.string  :cidade,   :limit => 60
      t.string  :uf,       :limit => 2
      t.string  :obs,      :limit => 100
      t.integer :aniver_dia
      t.integer :aniver_mes

      t.timestamps
    end
  end

  def self.down
    drop_table :clientes
  end
end