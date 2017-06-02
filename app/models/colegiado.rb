# :nodoc:
class Colegiado < ApplicationRecord
  include ActiveModel::Dirty
  define_attribute_methods
  include Filtrable
  include Validador
  # Relaciones
  belongs_to :regimen_colegiado
  belongs_to :titulacion, optional: true
  has_many :direccion_colegiados, inverse_of: :colegiado, dependent: :destroy
  has_many :cargo_colegiados, inverse_of: :colegiado, dependent: :destroy
  has_many :movimiento_colegiados, inverse_of: :colegiado, dependent: :destroy
  has_many :recompensa_colegiados, inverse_of: :colegiado, dependent: :destroy
  has_many :documento_colegiados, inverse_of: :colegiado, dependent: :destroy
  # Campos y validaciones
  accepts_nested_attributes_for :direccion_colegiados,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :movimiento_colegiados,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :cargo_colegiados,
                                allow_destroy: true,
                                reject_if: :all_blank
  accepts_nested_attributes_for :recompensa_colegiados,
                                allow_destroy: true,
                                reject_if: :all_blank
  has_attached_file :fotografia,
                    styles: { thumb: '150x150>' },
                    default_url: '/assets/missing.png',
                    path: ':rails_root/public/system/:attachment/:id/:filename',
                    url: '/system/:attachment/:id/:filename'
  validates_attachment :fotografia,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'],
                                       message: 'El formato de la imagen es incorrecto' },
                       size: { in: 0..1024.kilobytes, message: 'El archivo de la fotografía demasiado grande' }
  # Validaciones
  validates_presence_of :numero, :nombre, :apellidos, :nif
  validates :numero, numericality: { only_integer: true,
                                     message: 'Formato de número incorrecto' }
  validates :nombre, length: { minimum: 2, message: 'El nombre debe tener
                                                    una longitud mínima de 2 caracteres' }
  validates :apellidos, length: { minimum: 2, message: 'El apellido debe tener
                                                    una longitud mínima de 2 caracteres' }
  validates :email, allow_blank: true,
                    uniqueness: { message: 'Este email ya existe' },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/,
                              message: 'Formato de correo electrónico incorrecto' }
  validates :nif, uniqueness: { message: 'Este NIF ya existe para otro colegiado' }
  validate :check_nif
  # Callbacks
  before_save :check_baja
  # Scope
  default_scope { order(apellidos: :asc) }
  scope :activos, (-> { where baja_colegio: ['', nil] })
  scope :de_baja, (-> { where.not baja_colegio: ['', nil] })
  scope :regimen, (->(regimen) { where regimen_colegiado_id: regimen })
  scope :antiguedad, (->(antiguedad) { where('baja_colegio is NULL AND alta_colegio <= ?', antiguedad.to_i.years) })
  # Incluir estados
  scope :censo_electoral, (-> { where('baja_colegio is NULL AND alta_colegio <= ?', 1.month.ago) })
  scope :elegibles,
        (-> { where('baja_colegio is NULL AND alta_colegio < ?', Date.today - @colegio.antiguedad_elegible.years) })

  def nombre_completo
    [apellidos, nombre].compact.join(', ')
  end

  def nombre_texto
    [nombre, apellidos].compact.join(' ')
  end

  def estado
    return 'alta' unless baja_colegio
    'baja'
  end

  def importe_recibos
    documento_colegiados.solo_recibos.inject(0) { |sum, recibo| sum + recibo.importe }
  end

  def cargo_actual
    puesto_actual = cargo_colegiados.select(&:fecha_baja).first
    puesto_actual ? puesto_actual.cargo.nombre : 'Sin Cargo'
  end

  def direccion_principal
    direccion_colegiados.select(&:principal).first
  end

  def en_censo?
    excluido_censo ? 'No' : 'Sí'
  end

  def self.buscar(cadena)
    where('ILIKE(nombre) LIKE :cadena OR ILIKE(apellidos) LIKE :cadena', cadena: "%#{cadena.downcase}%")
  end

  private

  def check_nif
    return true unless nif && !nif.blank?
    validar_nif(nif)
  end

  def check_baja
    self.causa_baja_id = nil unless baja_colegio
  end
end
