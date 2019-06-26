class AddRefOldToProdutos < ActiveRecord::Migration[5.2]
  def change
    add_column :produtos, :ref_old, :string

    Produto.all.each { |p| p.update_columns ref_old: p.ref, ref: p.ref1 }
  end
end
