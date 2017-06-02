# Controlador de Colegiados
class ColegiadosController < ApplicationController
  load_and_authorize_resource
  before_action :set_colegiado, only: %i[edit update destroy]

  def show; end

  def index
    @colegiados = Colegiado.all
  end

  def new
    @colegiado = Colegiado.new
  end

  def create
    @colegiado = Colegiado.new(colegiado_params)
    if @colegiado.save
      @colegiados = Colegiado.all
      flash.now[:success] = "El nuevo colegiado #{@colegiado.nombre_completo} se ha creado correctamente"
    else
      flash.now[:error] = "No ha sido posible crear el colegiado #{@colegiado.nombre_completo}"
    end
  end

  def update
    identificar_movimientos
    if @colegiado.update(colegiado_params)
      set_movimiento
      @colegiados = Colegiado.all
      flash.now[:success] = "El colegiado #{@colegiado.nombre_completo} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar el colegiado #{@colegiado.nombre_completo}"
    end
  end

  def destroy
    nombre = @colegiado.nombre_completo
    if @colegiado.destroy
      @colegiados = Colegiado.all
      flash.now[:success] = "El colegiado #{nombre} se ha eliminado"
    else
      flash.now[:error] = "No ha sido posible eliminar al colegiado #{nombre}"
    end
  end

  # Aplica los filtros seleccionados y recarga el listado de colegiados
  def filter
    @colegiados = Colegiado.filtrar(params.slice(:regimen, :antiguedad, :censo_electoral, :elegibles))
    if params['estado'].eql?('alta')
      @colegiados = @colegiados.activos
    elsif params['estado'].eql?('baja')
      @colegiados = @colegiados.de_baja
    end
  end

  def listado
    @colegiados = Colegiado.all
  end

  def principal
    @colegiados = Colegiado.all
  end

  def presentar_documento
    @colegiado = Colegiado.find(params['colegiado_id'])
    @documento = Documento.find(params['documento_id'])
    if @documento.codigo != 'recibo'
      @documento_html = ApplicationController.render(template: cuerpo_documento,
                                                     layout: false,
                                                     assigns: { colegio: @colegio,
                                                                colegiado: @colegiado,
                                                                documento: @documento })
    end
  end

  private

  def colegiado_params
    keys = [:numero, :nombre, :apellidos, :nif, :nacimiento, :genero, :fotografia,
            :email, :telefono_fijo, :telefono_movil, :fax, :cuenta_bancaria,
            :alta_colegio, :baja_colegio, :regimen_colegiado_id, :direccion_colegiado_id,
            :jura, :epp, :nombre_empresa, :nif_empresa, :observaciones, :excluido_censo,
            :titulacion_id, :numero_archivo,
            direccion_colegiados_attributes: %i[id descripcion direccion codigo_postal
                                                provincia_id poblacion principal _destroy],
            cargo_colegiados_attributes: %i[id _destroy colegiado_id cargo_id],
            movimiento_colegiados_attributes: %i[id _destroy observaciones colegiado_id
                                                 tipo_movimiento_id regimen_colegiado_id],
            recompensa_colegiados_attributes: %i[id _destroy fecha recompensa]]
    params.require(:colegiado).permit(keys)
  end

  def filter_params
    keys = %i[regimen antiguedad estado censo_electoral elegibles]
    params.permit(keys)
  end

  def cuerpo_documento
    "pdfs/cuerpo_#{@documento.codigo}"
  end

  def identificar_movimientos
    @colegiado.regimen_colegiado_id_will_change! if @colegiado.regimen_colegiado_id_changed?
    @colegiado.baja_colegio_will_change! if @colegiado.baja_colegio_changed?
  end

  def set_colegiado
    @colegiado = Colegiado.find(params['id'])
  end

  # En las modificaciones valida si los campos de regimen o baja de colegiado se han modificado
  # y crea la nueva entrada en la tabla de movimientos del colegiado
  def set_movimiento
    if @colegiado.regimen_colegiado_id_previously_changed?
      crear_movimiento_regimen
    elsif @colegiado.baja_colegio_previously_changed?
      tipo = @colegiado.baja_colegio ? TipoMovimiento.find_by(codigo: 'B') : TipoMovimiento.find_by(codigo: 'A')
      crear_movimiento_colegiado(tipo, '')
    end
  end

  def crear_movimiento_regimen
    tipo_movimiento = TipoMovimiento.find_by(codigo: 'M')
    antiguo_regimen = RegimenColegiado.find(@colegiado.regimen_colegiado_id_previous_change[0])
    observaciones = "El régimen anterior era #{antiguo_regimen.literal}"
    crear_movimiento_colegiado(tipo_movimiento, observaciones)
  end

  def crear_movimiento_colegiado(tipo, observaciones)
    MovimientoColegiado.create(tipo_movimiento: tipo,
                               colegiado: @colegiado,
                               regimen_colegiado: @colegiado.regimen_colegiado,
                               observaciones: observaciones)
  end
end
