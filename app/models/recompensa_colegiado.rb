# Gestion manual de los cargos y recompensas del colegiado
class RecompensaColegiado < ApplicationRecord
  # Relaciones
  belongs_to :colegiado, inverse_of: :recompensa_colegiados
  # Validaciones
  validates_presence_of :fecha, :recompensa
end
