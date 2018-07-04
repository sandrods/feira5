class FornecedorNullableOnSacolas < ActiveRecord::Migration
  def change
    change_column :sacolas, :vendedor_id, :integer, null: true
  end
end
