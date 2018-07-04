class CreateFormas < ActiveRecord::Migration
  def change
    create_table :formas do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
