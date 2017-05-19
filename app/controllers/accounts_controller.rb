# Controlador de cuentas bancarias del Colegio
class AccountsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_cuenta, only: %i[edit update destroy]

  def index
    @cuentas = Account.all
  end

  def new
    @cuenta = Account.new
  end

  def edit; end

  def create
    @cuenta = Account.new(cuenta_params)
    if @cuenta.save
      @cuentas = Account.all
      flash.now[:success] = "La nueva cuenta bancaria del #{@cuenta.banco.nombre} se ha creado correctamente"
    else
      flash.now[:error] = "No ha sido posible crear la cuenta del #{@cuenta.banco.nombre}"
    end
  end

  def update
    if @cuenta.update(cuenta_params)
      @cuentas = Account.all
      flash.now[:success] = "La cuenta del #{@cuenta.banco.nombre} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar la cuenta del #{@cuenta.banco.nombre}"
    end
  end

  def destroy
    nombre = @cuenta.banco.nombre
    if @cuenta.destroy
      @cuentas = Account.all
      flash.now[:success] = "La cuenta del #{nombre} se ha eliminado"
    else
      flash.now[:error] = "No ha sido posible eliminar la cuenta del #{nombre}"
    end
  end

  private

  def cuenta_params
    keys = %i[banco_id oficina digitos_control cuenta]
    params.require(:account).permit(keys)
  end

  def set_cuenta
    @cuenta = Account.find(params['id'])
  end
end
