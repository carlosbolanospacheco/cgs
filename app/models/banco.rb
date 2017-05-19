# :nodoc:
class Banco < ApplicationRecord
  # Validaciones
  validates_presence_of :nombre, :codigo_pais, :codigo_entidad, :codigo_localidad, :clave_entidad
  validates :codigo_pais, length: { is: 2, message: '%{value} no es válido' }
  validates :codigo_entidad, length: { is: 4,
                                       message: 'El código de entidad %{value} no es válido,
                                                debe tener una longitud de 4 caracteres' }
  validates :codigo_localidad, length: { is: 2,
                                         message: 'El código de localidad %{value} no es válido,
                                                   debe tener una longitud de 2 caracteres' }
  validates :clave_entidad, numericality: { only_integer: true,
                                            message: 'La clave de entidad debe ser numérica,
                                                      el valor %{value} es incorrecto' }
  # Scopes
  default_scope { order(nombre: :asc) }
  # Callbacks
  before_save :codigos_mayusculas

  def bic
    [codigo_entidad, codigo_pais, codigo_localidad].compact.join(' ')
  end

  private

  def codigos_mayusculas
    codigo_entidad.upcase!
    codigo_localidad.upcase!
  end
end
