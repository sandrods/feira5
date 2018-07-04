class AddGeradaToEtiquetas < ActiveRecord::Migration
  def change
    add_column :etiquetas, :gerada, :boolean, default: false
    add_column :etiquetas, :mark, :datetime

    Etiqueta.update_all gerada: false
  end
end
