class AddColecaoIdToCompras < ActiveRecord::Migration
  def change
    add_reference :compras, :colecao, index: true, foreign_key: true
    add_reference :registros, :colecao, index: true, foreign_key: true
  end
end
