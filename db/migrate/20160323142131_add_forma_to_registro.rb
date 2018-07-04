class AddFormaToRegistro < ActiveRecord::Migration
  def change
    add_reference :registros, :forma, index: true, foreign_key: true
  end
end
