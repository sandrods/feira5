class AddValorNfToCompras < ActiveRecord::Migration[5.2]
  def change
    add_column :compras, :valor_nf, :decimal, scale: 2, precision: 9
  end
end
