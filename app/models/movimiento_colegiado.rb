# :nodoc:
class MovimientoColegiado < ApplicationRecord
  # Relaciones
  belongs_to :colegiado, inverse_of: :movimiento_colegiados
  belongs_to :tipo_movimiento
  belongs_to :regimen_colegiado
  # Validaciones
  validates_presence_of :colegiado_id, :regimen_colegiado_id, :tipo_movimiento_id
end
