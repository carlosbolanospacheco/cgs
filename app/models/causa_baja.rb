# :nodoc:
class CausaBaja < ApplicationRecord
  validates_presence_of :codigo, :nombre
  default_scope { order(nombre: :asc) }
  before_save :codigo_mayusculas

  private

  def codigo_mayusculas
    codigo.upcase!
  end
end
