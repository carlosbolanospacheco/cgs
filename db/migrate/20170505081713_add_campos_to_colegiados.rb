class AddCamposToColegiados < ActiveRecord::Migration[5.0]
  def change
    add_column :colegiados, :titulacion_id, :integer
    add_column :colegiados, :numero_archivo, :integer
    add_attachment :colegiados, :certificado_colegiacion
    add_attachment :colegiados, :certificado_cuotas
  end
end
