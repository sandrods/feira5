class AddContaToForma < ActiveRecord::Migration
  def change
    add_reference :formas, :conta, index: true, foreign_key: true
  end
end
