# Posibles causas de baja
class CausaBajasController < ApplicationController
  load_and_authorize_resource
  before_action :set_causa_baja, only: %i[edit update destroy]

  def index
    @causa_bajas = CausaBaja.all
  end

  def new
    @causa_baja = CausaBaja.new
  end

  def edit; end

  def create
    @causa_baja = CausaBaja.new(causa_baja_params)
    if @causa_baja.save
      @causa_bajas = CausaBaja.all
      flash.now[:success] = "La nueva causa #{@causa_baja.nombre} se ha creado correctamente"
    else
      flash.now[:error] = "No ha sido posible crear la causa #{@causa_baja.nombre}"
    end
  end

  def update
    if @causa_baja.update(causa_baja_params)
      @causa_bajas = CausaBaja.all
      flash.now[:success] = "La causa #{@causa_baja.nombre} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar la causa #{@causa_baja.nombre}"
    end
  end

  def destroy
    nombre = @causa_baja.nombre
    if @causa_baja.destroy
      @causa_bajas = CausaBaja.all
      flash.now[:success] = "La causa #{nombre} se ha eliminado"
    else
      flash.now[:error] = "No ha sido posible eliminar la causa #{nombre}"
    end
  end

  private

  def causa_baja_params
    keys = %i[nombre codigo]
    params.require(:causa_baja).permit(keys)
  end

  def set_causa_baja
    @causa_baja = CausaBaja.find(params['id'])
  end
end
