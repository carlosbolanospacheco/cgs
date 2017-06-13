# Controlador de colegios. Se considera un unico colegio
class ColegiosController < ApplicationController
  load_and_authorize_resource
  before_action :set_colegio, only: %i[edit update]

  def edit; end

  def update
    if @colegio.update(colegio_params)
      flash.now[:success] = "Los datos del #{@colegio.nombre} se han actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar los datos del #{@colegio.nombre}"
    end
  end

  def presentar_documento
    @documento = Documento.find(params['documento_id'])
    if @documento.codigo == 'modelo_13'
       calcular_valores_modelo_13
       @mes = params['mes'].to_i
       @anyo = params['anyo'].to_i
    else
      @documento_html = ApplicationController.render(template: cuerpo_documento,
                                                     layout: false,
                                                     assigns: { colegio: @colegio,
                                                                documento: @documento})
    end
  end

  def listado_documentos; end

  def modelo_13; end

  private

  def colegio_params
    keys = %i[nombre logo_colegio logo_escuela logo_formacion direccion poblacion
              codigo_postal provincia_id cif telefono fax sufijo url antiguedad_elegible]
    params.require(:colegio).permit(keys)
  end

  def calcular_valores_modelo_13
    @valores_modelo_13 = Array.new
    RegimenColegiado.regimenes_activos.each do |regimen|
      elemento = { tipo: '', total_colegiados: 0, base_imponible: 0.0, liquidar: 0.0, ingresar: 0.0 }
      elemento[:tipo] = regimen[:literal]
      elemento[:base_calculo] = regimen[:importe_colegio]
      elemento[:liquidar] = regimen[:porcentaje_a_pagar]
      elemento[:total_colegiados] = Colegiado.activos_en_fecha(params['mes'].to_i, params['anyo'].to_i).where(regimen_colegiado: regimen).count
      elemento[:base_calculo] = elemento[:base_calculo].to_f
      elemento[:base_imponible] = elemento[:base_calculo].to_f * elemento[:total_colegiados].to_f
      elemento[:ingresar] = (elemento[:base_imponible] * regimen[:porcentaje_a_pagar].to_f) / 100
      @valores_modelo_13.push elemento
    end
    @valores_modelo_13
  end

  def set_colegio
    @colegio = Colegio.find(params['id'])
  end

  def cuerpo_documento
    "pdfs/cuerpo_#{@documento.codigo}"
  end

end
