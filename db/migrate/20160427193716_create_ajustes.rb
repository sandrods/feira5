class CreateAjustes < ActiveRecord::Migration
  def change
    create_table :ajustes do |t|
      t.string :tipo, limit: 1
      t.string :obs

      t.timestamps null: false
    end
  end
end
