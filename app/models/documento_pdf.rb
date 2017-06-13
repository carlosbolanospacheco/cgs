require 'render_anywhere'

class DocumentoPdf
  include RenderAnywhere
  include Ficheros

  attr_reader :nombre

  def initialize(colegio,
                 colegiados,
                 parametros,
                 documento,
                 orientacion,
                 host,
                 port,
                 margen_top='0.75in',
                 margen_der='0.75in',
                 margen_izq='0.75in',
                 margen_bot='0.75in')
    @colegio = colegio
    @colegiados = colegiados
    @parametros = parametros
    @documento = documento
    @orientacion = orientacion
    @margen_superior = margen_top
    @margen_derecha = margen_der
    @margen_izquierda = margen_izq
    @margen_inferior = margen_bot
    @nombre = nombre_fichero
    @host = host
    @port = port
  end

  def to_pdf
    kit = PDFKit.new(como_html,
                     page_size: 'A4',
                     orientation: orientacion,
                     margin_top: margen_superior,
                     margin_right: margen_derecha,
                     margin_left: margen_izquierda,
                     margin_bottom: margen_inferior,
                     footer_line: true)
    self.crear_ruta("#{Rails.root}/public/system/documentos/#{@documento.codigo}")
    kit.to_file("#{Rails.root}/public/system/documentos/#{@documento.codigo}/#{@nombre}")
  end

  def to_pdf_con_pie
    kit = PDFKit.new(como_html,
                     page_size: 'A4',
                     orientation: orientacion,
                     margin_top: margen_superior,
                     margin_right: margen_derecha,
                     margin_left: margen_izquierda,
                     margin_bottom: margen_inferior,
                     footer_line: true,
                     footer_font_size: 10,
                     footer_center: pie_html)
    registrar_documento
    self.crear_ruta("#{Rails.root}/public/system/documentos/#{@documento.codigo}")
    kit.to_file("#{Rails.root}/public/system/documentos/#{@documento.codigo}/#{@nombre}")
  end

  private

  attr_reader :colegio, :colegiados, :parametros, :tipo, :orientacion, :margen_superior, :margen_inferior,
              :margen_derecha, :margen_izquierda

  def como_html
    render template: "pdfs/#{@documento.plantilla}",
           layout: 'pdf',
           locals: { colegio: @colegio,
                     colegiados: @colegiados,
                     parametros: @parametros,
                     documento: @documento,
                     host: @host, port: @port }
  end

  def pie_html
    ApplicationController.render(template: 'pdfs/pie',
                                 layout: false,
                                 assigns: { colegio: @colegio })
  end

  def registrar_documento
    @documento.documento_personal ? registrar_documento_colegiado : registrar_documento_colegio
  end

  def registrar_documento_colegiado
    doc = DocumentoColegiado.new(documento_colegiado_params)
    doc.nombre_documento = @nombre
    doc.save
  end

  def registrar_documento_colegio
    doc = DocumentoColegio.new(documento_colegio_params)
    doc.nombre_documento = @nombre
    doc.save
  end

  def documento_colegiado_params
    keys = %i[colegiado_id documento_id importe codigo_recibo concepto]
    @parametros.permit(keys)
  end

  def documento_colegio_params
    keys = %i[colegio_id documento_id mes anyo]
    @parametros.permit(keys)
  end

  def nombre_fichero
    if @documento.documento_personal
      "#{@colegiados.numero}_#{'%04d' % Time.now.year}#{'%02d' % Time.now.month}#{'%02d' % Time.now.day}_#{Time.now.to_i}.pdf"
    else
      "#{@documento.codigo}_#{'%04d' % Time.now.year}#{'%02d' % Time.now.month}#{'%02d' % Time.now.day}_#{Time.now.to_i}.pdf"
    end
  end
end
