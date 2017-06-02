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
    @documento_html = ApplicationController.render(template: cuerpo_documento,
                                                   layout: false,
                                                   assigns: { colegio: @colegio,
                                                              documento: @documento })
  end

  def listado_documentos; end

  private

  def colegio_params
    keys = %i[nombre logo_colegio logo_escuela logo_formacion direccion poblacion
              codigo_postal provincia_id cif telefono fax sufijo url antiguedad_elegible]
    params.require(:colegio).permit(keys)
  end

  def set_colegio
    @colegio = Colegio.find(params['id'])
  end

  def cuerpo_documento
    "pdfs/cuerpo_#{@documento.codigo}"
  end

end
