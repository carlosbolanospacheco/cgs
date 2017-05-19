class Colegio < ApplicationRecord
  belongs_to :provincia

  has_attached_file :logo_colegio,
                    styles: { thumb: '150x150>' },
                    default_url: '/assets/:style/no_disponible.png',
                    path: ':rails_root/public/system/:attachment/:id/:filename',
                    url: '/system/:attachment/:id/:filename'
  validates_attachment :logo_colegio,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
                       size: { in: 0..1024.kilobytes }

  has_attached_file :logo_escuela,
                    styles: { thumb: '150x150>' },
                    default_url: '/assets/:style/no_disponible.png',
                    path: ':rails_root/public/system/:attachment/:id/:filename',
                    url: '/system/:attachment/:id/:filename'
  validates_attachment :logo_escuela,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
                       size: { in: 0..1024.kilobytes }

  has_attached_file :logo_formacion,
                    styles: { thumb: '150x150>' },
                    default_url: '/assets/:style/no_disponible.png',
                    path: ':rails_root/public/system/:attachment/:id/:filename',
                    url: '/system/:attachment/:id/:filename'
  validates_attachment :logo_formacion,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
                       size: { in: 0..1024.kilobytes }
  validates_presence_of :nombre, :direccion, :poblacion, :codigo_postal, :cif, :antiguedad_elegible
  validates :antiguedad_elegible, numericality: { only_integer: true,
                                                  message: 'La antigüedad indicada es incorrecta' }
end
