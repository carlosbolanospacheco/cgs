# Controlador de los documentos que se generan
class DocumentosController < ApplicationController
  load_and_authorize_resource
  before_action :set_documento, only: %i[edit update]

  def index
    @documentos = Documento.all
  end

  def edit; end

  def update
    if @documento.update(documento_params)
      @documentos = Documento.all
      flash.now[:success] = "El documento #{@documento.nombre} se ha actualizado correctamente"
    else
      flash.now[:error] = "No ha sido posible actualizar el documento #{@documento.nombre}"
    end
  end

  private

  def documento_params
    keys = %i[nombre codigo firma_1_cargo_id firma_2_cargo_id]
    params.require(:documento).permit(keys)
  end

  def set_documento
    @documento = Documento.find(params['id'])
  end
end
