class CreateCausaBajas < ActiveRecord::Migration[5.0]
  def change
    create_table :causa_bajas do |t|
      t.string  :codigo
      t.string  :nombre
    end
  end
end
