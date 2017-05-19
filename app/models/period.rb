# :nodoc:
class Period < ApplicationRecord
  validates_presence_of :nombre, :multiplicador
  validates :multiplicador, numericality: { only_integer: true,
                                            message: 'El multiplicador debe ser numérico,
                                                      el valor %{value} es incorrecto' }
end
