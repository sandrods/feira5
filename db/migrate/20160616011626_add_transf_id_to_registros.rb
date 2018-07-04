class AddTransfIdToRegistros < ActiveRecord::Migration
  def change
    add_column :registros, :transf_id, :integer, index: true
  end
end
