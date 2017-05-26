class CreateDocumentos < ActiveRecord::Migration[5.0]
  def change
    create_table :documentos do |t|
      t.string  :nombre
      t.string  :codigo
      t.string  :plantilla
      t.integer :firma_1_cargo_id
      t.integer :firma_2_cargo_id
      t.boolean :documento_personal, default: true

      t.timestamps
    end
  end
end
