# Documentos que se generan y sus firmas
class Documento < ApplicationRecord
  # belongs_to :cargos, classname: 'Cargo', foreign_key: 'firma_1_cargo_id'
  # belongs_to :cargos, classname: 'Cargo', foreign_key: 'firma_2_cargo_id'
  belongs_to :firma_1_cargo, class_name: :Cargo
  belongs_to :firma_2_cargo, class_name: :Cargo
  # Validaciones
  validates_presence_of :nombre, :codigo
  validates :nombre, length: { minimum: 5,
                               message: 'El nombre debe tener
                                         una longitud mínima de 5 caracteres' }
  validates :codigo,
            uniqueness: { message: 'Este código de documento ya existe' },
            length: { minimum: 5,
                      message: 'La longitud mínima del código deben ser 5 caracteres' }
  # Scope
  default_scope { order(nombre: :asc) }

  def individual?
    documento_personal ? 'Sí' : 'No'
  end
end
