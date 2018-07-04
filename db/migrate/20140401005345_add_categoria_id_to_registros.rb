class AddCategoriaIdToRegistros < ActiveRecord::Migration
  def change
    add_column :registros, :categoria_id, :integer
  end
end
