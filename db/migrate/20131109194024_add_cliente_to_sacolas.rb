class AddClienteToSacolas < ActiveRecord::Migration
  def change
    add_column :sacolas, :cliente_id, :integer
    add_column :sacolas, :tipo, :string, limit: 1
  end
end
