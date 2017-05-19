# :nodoc:
class RegimenColegiado < ApplicationRecord
  belongs_to :period
  validates_presence_of :literal
  default_scope { order(literal: :asc) }
end
