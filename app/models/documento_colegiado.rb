# Documentos generados para los colegiados.
class DocumentoColegiado < ApplicationRecord
  belongs_to :colegiado, inverse_of: :documento_colegiados
  belongs_to :documento
  # Validaciones
  validates_presence_of :colegiado_id, :documento_id, :nombre_documento
  validates :nombre_documento, uniqueness: { message: 'Este documento ya existe' }
  # Scope
  default_scope { order(created_at: :desc) }
  scope :solo_recibos, (-> { joins(:documento).merge(Documento.where(codigo: 'recibo')) })
  scope :sin_recibos, (-> { joins(:documento).merge(Documento.where.not(codigo: 'recibo')) })

  def obtener_ruta
    "#{Rails.root}/public/system/documentos/#{documento.codigo}/#{nombre_documento}"
  end
end
