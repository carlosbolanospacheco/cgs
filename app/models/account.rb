# Cuentas bancarias del Colegio
class Account < ApplicationRecord
  belongs_to :banco
  # Validaciones
  validates_presence_of :oficina, :digitos_control, :cuenta
  validates :oficina, numericality: { only_integer: true,
                                      message: 'La oficina debe ser un número, el valor %{value} es incorrecto' }
  validates :cuenta, numericality: { only_integer: true,
                                     message: 'La cuenta debe ser un número, el valor %{value} es incorrecto' }
  # Callbacks
  before_save :check_digitos_control
  before_save :calculate_iban

  private

  def calculate_iban
    # return true unless banco.codigo_pais == 'ES'
    self.iban = 'ES' + iban_cc + banco.clave_entidad + oficina + digitos_control + cuenta
    true
  end

  def check_digitos_control
    return true if digitos_control == calcular_digito_control
    errors.add(:digitos_control, 'Los dígitos de control son incorrectos')
    throw(:abort)
  end

  def calcular_digito_control
    digito_control = ''
    digito_control << obtener_digito(banco.clave_entidad + oficina, 2)
    digito_control << obtener_digito(cuenta, 0)
    digito_control
  end

  def iban_cc
    '%02d' % (98 - ((banco.clave_entidad + oficina + digitos_control + cuenta + '142800').to_i % 97))
  end

  def obtener_digito(cadena, offset)
    digitos = [1, 2, 4, 8, 5, 10, 9, 7, 3, 6]
    sum = 0
    cadena.split('').each_with_index { |a, index| sum += (a.to_i * digitos[index + offset]) }
    return '0' unless sum % 11 > 0
    return '1' if sum % 11 == 10
    (11 - (sum % 11)).to_s
  end
end
