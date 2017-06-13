# Controlador de usuarios
class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      @users = User.all
      flash.now[:success] = "El nuevo usuario #{@user.nombre_completo} se ha creado correctamente"
    else
      flash.now[:error] = "No ha sido posible crear el usuario #{@user.nombre_completo}"
    end
  end

  def update
    user_update_params = user_params
    if user_update_params[:password].blank?
      user_update_params.delete(:password)
      user_update_params.delete(:password_confirmation)
      user_update_params.delete(:current_password)
    end
    if @user.update(user_update_params)
      @users = User.all
      flash.now[:success] = "El usuario #{@user.nombre_completo} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar el usuario #{@user.nombre_completo}"
    end
  end

  def destroy
    nombre = @user.nombre_completo
    if @user.destroy
      @users = User.all
      flash.now[:success] = "El usuario #{nombre} se ha eliminado"
    else
      flash.now[:error] = "No ha sido posible eliminar el usuario #{nombre}"
    end
  end

  private

  def user_params
    keys = %i[nombre apellidos email avatar password password_confirmation current_password
              superadmin_role supervisor_role user_role remember_me username]
    params.require(:user).permit(keys)
  end

  def set_user
    @user = User.find(params['id'])
  end
end
