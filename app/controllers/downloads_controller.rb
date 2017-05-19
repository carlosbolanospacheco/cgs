class DownloadsController < ApplicationController
  def listado_colegiados
    respond_to do |format|
      format.pdf { enviar_listado_pdf }
    end
  end

  private

  def filtrar_colegiados
    colegiados = Colegiado.filtrar(params.slice(:regimen, :antiguedad, :censo_electoral, :elegibles))
    if params['estado'].eql?('alta')
      colegiados = colegiados.activos
    elsif params['estado'].eql?('baja')
      colegiados = colegiados.de_baja
    end
    colegiados
  end

  def doc_pdf
    DocumentoPdf.new(filtrar_colegiados, listado_colegiados_params)
  end

  def enviar_listado_pdf
    send_file doc_pdf.to_pdf,
              filename: doc_pdf.filename,
              type: 'application/pdf',
              disposition: 'inline'
  end

  def listado_colegiados_params
    keys = %i[regimen antiguedad estado censo_electoral elegibles nif genero fecha_nacimiento
              estado email telefono_fijo telefono_movil fax fecha_alta fecha_baja titulacion
              empresa cif_empresa regimen jura epp archivo censo]
    params.permit(keys)
  end
end
