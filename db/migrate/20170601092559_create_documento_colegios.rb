class CreateDocumentoColegios < ActiveRecord::Migration[5.0]
  def change
    create_table :documento_colegios do |t|
      t.integer :colegio_id
      t.integer :documento_id
      t.string  :nombre_documento

      t.timestamps
    end
  end
end
