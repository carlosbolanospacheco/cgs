class DownloadsController < ApplicationController
  def listado_colegiados
    respond_to do |format|
      format.pdf { enviar_listado_pdf }
    end
  end

  def etiquetas
    respond_to do |format|
      format.pdf { enviar_etiquetas_pdf }
    end
  end

  def generar_documento
    @documento = Documento.find(params['documento_id'])
    @colegiado = Colegiado.find(params['colegiado_id']) if params['colegiado_id']
    @colegio = Colegio.find(params['colegio_id']) if params['colegio_id']
    respond_to do |format|
      format.pdf { enviar_documento_pdf }
    end
  end

  private

  def enviar_documento_pdf
    send_file documento_pdf.to_pdf_con_pie,
              filename: documento_pdf.nombre,
              type: 'application/pdf',
              disposition: 'inline'
  end

  def enviar_listado_pdf
    send_file colegiados_pdf.to_pdf,
              filename: colegiados_pdf.nombre,
              type: 'application/pdf',
              disposition: 'inline'
  end

  def enviar_etiquetas_pdf
    send_file etiquetas_pdf.to_pdf,
              filename: etiquetas_pdf.nombre,
              type: 'application/pdf',
              disposition: 'inline'
  end

  def filtrar_colegiados
    colegiados = nil
    if params[:colegiados_ids] && !params[:colegiados_ids].empty?
      ids = params[:colegiados_ids].split(',')
      logger.debug("Buscando los colegiados con ids #{ids}")
      colegiados = Colegiado.where(id: ids)
    else
      colegiados = Colegiado.filtrar(params.slice(:regimen, :antiguedad, :censo_electoral, :elegibles))
      if params['estado'].eql?('alta')
        colegiados = colegiados.activos
      elsif params['estado'].eql?('baja')
        colegiados = colegiados.de_baja
      end
    end
    colegiados
  end

  def documento_pdf
    DocumentoPdf.new(@colegio,
                     @colegiado,
                     documento_params,
                     @documento,
                     'Portrait',
                     request.host, request.port)
  end

  def colegiados_pdf
    DocumentoPdf.new(@colegio,
                     filtrar_colegiados,
                     listado_colegiados_params,
                     Documento.find_by(codigo: 'listado'),
                     'Landscape',
                     request.host, request.port)
  end

  def etiquetas_pdf
    DocumentoPdf.new(@colegio,
                     Colegiado.activos,
                     nil,
                     Documento.find_by(codigo: 'etiqueta'),
                     'Portrait',
                     request.host, request.port,
                     '0in', '0in', '.01in', '0in')
  end

  def documento_params
    keys = %i[cuerpoDocumento colegio_id colegiado_id documento_id codigo_recibo concepto importe]
    params.permit(keys)
  end

  def listado_colegiados_params
    keys = %i[colegiados_ids regimen antiguedad estado_colegiado censo_electoral elegibles nif genero fecha_nacimiento
              estado email telefono_fijo telefono_movil fax fecha_alta fecha_baja titulacion
              empresa cif_empresa regimen jura epp archivo censo]
    params.permit(keys)
  end
end
