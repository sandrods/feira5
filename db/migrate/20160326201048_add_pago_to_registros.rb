class AddPagoToRegistros < ActiveRecord::Migration
  def change
    add_column :registros, :pago, :boolean, default: false
    remove_column :registros, :data_pagamento
  end
end
