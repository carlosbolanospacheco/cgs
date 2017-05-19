class CreateTitulaciones < ActiveRecord::Migration[5.0]
  def change
    create_table :titulaciones do |t|
      t.string :nombre
    end
  end
end
