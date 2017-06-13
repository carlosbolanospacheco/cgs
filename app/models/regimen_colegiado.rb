# :nodoc:
class RegimenColegiado < ApplicationRecord
  belongs_to :period
  # Validaciones
  validates_presence_of :literal
  # Scope
  default_scope { order(literal: :asc) }
  scope :regimenes_activos, (-> { where activo: true })
end
