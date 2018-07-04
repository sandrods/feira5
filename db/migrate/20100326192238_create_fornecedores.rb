class CreateFornecedores < ActiveRecord::Migration
  def self.up
    create_table :fornecedores, :force => true do |t|
      t.string :nome, :limit => 30, :null => false
      
      t.string :email,      :limit => 60
      t.string :website,    :limit => 60
      t.string :fone,       :limit => 30
      t.string :cnpj,       :limit => 20
      t.string :endereco,   :limit => 80
      t.string :bairro,     :limit => 30
      t.string :cep,        :limit => 8
      t.string :cidade,     :limit => 30
      t.string :uf,         :limit => 2
      t.string :obs,        :limit => 200

      t.timestamps
    end
  end

  def self.down
    drop_table :fornecedores
  end
end
