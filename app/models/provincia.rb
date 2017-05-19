# :nodoc:
class Provincia < ApplicationRecord
  self.table_name = 'provincias'
  validates_presence_of :codigo, :nombre
end
