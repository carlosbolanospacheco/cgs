# Historial de cargos y recompensas de un colegiado
class CargoColegiado < ApplicationRecord
  # Relaciones
  belongs_to :colegiado, inverse_of: :cargo_colegiados
  belongs_to :causa_baja, optional: true
  belongs_to :cargo
  # Validaciones
  validates_presence_of :colegiado_id, :cargo_id, :alta
end
