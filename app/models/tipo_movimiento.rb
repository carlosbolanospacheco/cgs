# :nodoc:
class TipoMovimiento < ApplicationRecord
  validates_presence_of :codigo, :literal
end
