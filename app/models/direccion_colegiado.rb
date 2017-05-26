# Direcciones postales de los colegiados
class DireccionColegiado < ApplicationRecord
  belongs_to :colegiado, inverse_of: :direccion_colegiados
  belongs_to :provincia
  # Validaciones
  validates_presence_of :colegiado_id, :direccion, :codigo_postal, :provincia, :poblacion
end
