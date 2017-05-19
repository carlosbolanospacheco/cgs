class UserMailer < ApplicationMailer
  default from: 'Colegio de Graduados Sociales de Asturias <no-reply@graduadosocialasturias.com>'

  def send_welcome_email(user)
    mail to: user.email,
         subject: 'Bienvenido a la aplicación de gestión de colegiados',
         nombre: user.nombre_completo
  end
end
