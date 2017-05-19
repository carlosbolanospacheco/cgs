class EliminarCamposColegiado < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :colegiados, :certificado_colegiacion
    remove_attachment :colegiados, :certificado_cuotas
  end
end
