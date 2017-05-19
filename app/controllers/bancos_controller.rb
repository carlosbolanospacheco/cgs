# Controlador de entidades bancarias
class BancosController < ApplicationController
  load_and_authorize_resource
  before_action :set_banco, only: %i[edit update destroy]

  def index
    @bancos = Banco.all
  end

  def new
    @banco = Banco.new
  end

  def edit; end

  def create
    @banco = Banco.new(banco_params)
    if @banco.save
      @bancos = Banco.all
      flash.now[:success] = "La nueva entidad #{@banco.nombre} se ha creado correctamente"
    else
      flash.now[:error] = "No ha sido posible crear la entidad #{@banco.nombre}"
    end
  end

  def update
    if @banco.update(banco_params)
      @bancos = Banco.all
      flash.now[:success] = "La entidad #{@banco.nombre} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar la entidad #{@banco.nombre}"
    end
  end

  def destroy
    nombre = @banco.nombre
    if @banco.destroy
      @bancos = Banco.all
      flash.now[:success] = "La entidad #{nombre} se ha eliminado"
    else
      flash.now[:error] = "No ha sido posible eliminar la entidad #{nombre}"
    end
  end

  private

  def banco_params
    keys = %i[nombre codigo_pais codigo_entidad clave_entidad codigo_localidad]
    params.require(:banco).permit(keys)
  end

  def set_banco
    @banco = Banco.find(params['id'])
  end
end
