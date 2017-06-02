# :nodoc:
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do # |exception|
    flash[:error] = 'No tiene permisos para realizar esa acción'
    redirect_to '/'
  end

  def set_locale
    I18n.locale = I18n.default_locale # params[:locale] || I18n.default_locale
    @colegio = Colegio.first
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nombre apellidos email avatar
                                                         password password_confirmation
                                                         superadmin_role supervisor_role
                                                         user_role remember_me username])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[nombre apellidos email avatar
                                                         password superadmin_role supervisor_role
                                                         user_role remember_me username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nombre apellidos email avatar password
                                                                password_confirmation
                                                                superadmin_role supervisor_role
                                                                user_role remember_me username])
  end

  def mostrar_documento
    documento = DocumentoColegiado.find(params['documento_id'])
    send_file documento.obtener_ruta,
              filename: documento.nombre_documento,
              type: 'application/pdf',
              disposition: 'inline'
  end
end
