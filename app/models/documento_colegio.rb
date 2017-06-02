# Documento generado para el Colegio
class DocumentoColegio < ApplicationRecord
  belongs_to :colegio, inverse_of: :documento_colegios
  belongs_to :documento
  # Validaciones
  validates_presence_of :colegio_id, :documento_id, :nombre_documento
  validates :nombre_documento, uniqueness: { message: 'Este documento ya existe' }
  # Scope
  default_scope { order(created_at: :desc) }

  def obtener_ruta
    "#{Rails.root}/public/system/documentos/#{documento.codigo}/#{nombre_documento}"
  end
end
