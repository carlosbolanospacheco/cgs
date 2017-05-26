# Recibos que se generan para un colegiado
class ReciboColegiado < ApplicationRecord
  belongs_to :documento_colegiado, inverse_of: :recibo_colegiados
  # Validaciones
  validates_presence_of :colegiado_id, :documento_id, :nombre_documento
  validates :nombre_documento, uniqueness: { message: 'Este documento ya existe' }

  def obtener_ruta
    "#{Rails.root}/public/system/documentos/#{documento.codigo}/#{nombre_documento}"
  end
end
