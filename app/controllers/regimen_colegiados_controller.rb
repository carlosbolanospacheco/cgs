# Controlador de posibles regimenes del colegiado
class RegimenColegiadosController < ApplicationController
  load_and_authorize_resource
  before_action :set_regimen, only: %i[edit update]

  def index
    @regimenes = RegimenColegiado.all
  end

  def edit; end

  def update
    if @regimen.update(regimen_params)
      @regimenes = RegimenColegiado.all
      flash.now[:success] = "El régimen #{@regimen.literal} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar el régimen #{@regimen.literal}"
    end
  end

  private

  def regimen_params
    keys = %i[literal importe_colegio importe_consejo porcentaje_a_pagar period_id]
    params.require(:regimen_colegiado).permit(keys)
  end

  def set_regimen
    @regimen = RegimenColegiado.find(params['id'])
  end
end
