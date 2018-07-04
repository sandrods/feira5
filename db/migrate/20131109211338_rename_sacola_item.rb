class RenameSacolaItem < ActiveRecord::Migration
  def change
    rename_table :sacola_itens, :itens_sacola
  end
end
