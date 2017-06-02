# Cargos existentes en el colegio
class Cargo < ApplicationRecord
  include ActiveModel::Dirty
  define_attribute_methods
  belongs_to :colegiado
  has_many :cargo_colegiados
  # Callbacks
  before_save :clear_firma
  # Validaciones
  validates_presence_of :codigo, :nombre
  has_attached_file :firma,
                    styles: { thumb: '100x75>' },
                    default_url: '/assets/no_disponible.png',
                    path: ':rails_root/public/system/:attachment/:id/:filename',
                    url: '/system/:attachment/:id/:filename'
  validates_attachment :firma,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
                       size: { in: 0..1024.kilobytes }
  default_scope { order(nombre: :asc) }
  # Atributo usado para indicar la causa de baja de un colegiado en un cargo
  attr_accessor :causa_baja_id

  private

  def clear_firma
    firma.clear if !colegiado && firma.file?
  end
end
