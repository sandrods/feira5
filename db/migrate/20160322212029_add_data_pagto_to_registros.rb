class AddDataPagtoToRegistros < ActiveRecord::Migration
  def change
    add_column :registros, :data_pagamento, :date
  end
end
