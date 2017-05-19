class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :timeoutable, authentication_keys: [:login]
  after_create :send_welcome_email
  # Validaciones
  validates_presence_of :email, message: 'Debe indicar el correo electrónico'
  validates_presence_of :username, message: 'Debe indicar el nombre de usuario'
  validates_presence_of :password, :password_confirmation,
                        on: :create, message: 'Debe indicar la contraseña'
  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }
  validates :username,
            format: { with: /^[a-zA-Z0-9_\.]*$/,
                      message: 'Formato de usuario incorrecto, sólo se permiten letras, números, subrayado y puntos',
                      multiline: true }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/,
                              message: 'Formato de correo electrónico incorrecto' }
  validate :validate_username
  # Ficheros del modelo
  has_attached_file :avatar,
                    styles: { thumb: '150x150>' },
                    default_url: '/assets/missing.png',
                    path: ':rails_root/public/system/:attachment/:id/:filename',
                    url: '/system/:attachment/:id/:filename'
  validates_attachment :avatar,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'],
                                       message: 'El formato de la imagen es incorrecto' },
                       size: { in: 0..1024.kilobytes, message: 'El archivo de imagen es demasiado grande' }

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver
  end

  def rol
    return 'administrador' if superadmin_role?
    return 'supervisor' if supervisor_role?
    'usuario'
  end

  def login
    @login || username || email
  end

  def nombre_completo
    [nombre, apellidos].compact.join(' ')
  end

  private

  def validate_username
    errors.add(:username, 'Username ya existe como correo electrónico') if User.where(email: username).exists?
  end
end
