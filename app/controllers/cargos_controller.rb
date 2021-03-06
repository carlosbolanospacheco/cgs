# Cargos en el Colegio
class CargosController < ApplicationController
  load_and_authorize_resource
  before_action :set_cargo, only: %i[edit update destroy]

  def index
    @cargos = Cargo.all
  end

  def new
    @cargo = Cargo.new
  end

  def edit; end

  def create
    @cargo = Cargo.new(cargo_params)
    if @cargo.save
      @cargos = Cargo.all
      flash.now[:success] = "El nuevo cargo #{@cargo.nombre} se ha creado correctamente"
    else
      flash.now[:error] = "No ha sido posible crear el cargo #{@cargo.nombre}"
    end
  end

  def update
    @cargo.colegiado_id_will_change! if @cargo.colegiado_id_changed? && @cargo.colegiado
    causa_baja = cargo_params[:causa_baja_id]
    if @cargo.update(cargo_params)
      cambio_colegiado(causa_baja) if @cargo.colegiado_id_previously_changed?
      @cargos = Cargo.all
      flash.now[:success] = "El cargo #{@cargo.nombre} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar el cargo #{@cargo.nombre}"
    end
  end

  def destroy
    nombre = @cargo.nombre
    if @cargo.destroy
      @cargos = Cargo.all
      flash.now[:success] = "El cargo #{nombre} se ha eliminado"
    else
      flash.now[:error] = "No ha sido posible eliminar el cargo #{nombre}"
    end
  end

  private

  def cargo_params
    keys = %i[nombre codigo colegiado_id firma causa_baja_id] # nif nombre_completo tratamiento firma]
    params.require(:cargo).permit(keys)
  end

  def set_cargo
    @cargo = Cargo.find(params['id'])
  end

  def cambio_colegiado(causa_baja)
    cargo_saliente(causa_baja) if @cargo.colegiado_id_previous_change[0]
    return unless @cargo.colegiado
    CargoColegiado.create(colegiado: @cargo.colegiado,
                          cargo: @cargo,
                          alta: DateTime.now.to_date)
  end

  def cargo_saliente(causa_baja)
    antiguo_colegiado = Colegiado.find(@cargo.colegiado_id_previous_change[0])
    antiguo_cargo = CargoColegiado.find_by(colegiado: antiguo_colegiado,
                                           cargo: @cargo,
                                           baja: nil)
    if antiguo_cargo
      antiguo_cargo.baja = DateTime.now.to_date
      antiguo_cargo.causa_baja_id = causa_baja
      antiguo_cargo.save
    else
      CargoColegiado.create(colegiado: antiguo_colegiado,
                            cargo: @cargo,
                            alta: DateTime.now.to_date,
                            baja: DateTime.now.to_date,
                            causa_baja_id: causa_baja)
    end
  end
end
