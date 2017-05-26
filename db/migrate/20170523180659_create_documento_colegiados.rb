class CreateDocumentoColegiados < ActiveRecord::Migration[5.0]
  def change
    create_table :documento_colegiados do |t|
      t.integer :colegiado_id
      t.integer :documento_id
      t.string  :nombre_documento
      t.string  :codigo_recibo
      t.string  :concepto
      t.float   :importe

      t.timestamps
    end
  end
end
