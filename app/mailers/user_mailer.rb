class UserMailer < ApplicationMailer
  default from: 'Colegio de Graduados Sociales de Asturias <no-reply@graduadosocialasturias.com>'

  def send_welcome_email(user)
    @user = user
    mail to: user.email,
         subject: 'Bienvenido a la aplicación de gestión de colegiados'
  end
end
