class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :nome
      t.string :cd

      t.timestamps
    end
  end
end
