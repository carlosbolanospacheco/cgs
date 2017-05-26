require 'render_anywhere'

class DocumentoPdf
  include RenderAnywhere

  attr_reader :nombre

  def initialize(colegiados,
                 parametros,
                 documento,
                 orientacion,
                 host,
                 port,
                 margen_top = '0.75in',
                 margen_der = '0.75in',
                 margen_izq = '0.75in',
                 margen_bot = '0.75in')
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
    kit.to_file("#{Rails.root}/public/system/documentos/#{@documento.codigo}/#{@nombre}")
  end

  private

  attr_reader :colegiados, :parametros, :tipo, :orientacion, :margen_superior, :margen_inferior,
              :margen_derecha, :margen_izquierda

  def como_html
    render template: "pdfs/#{@documento.plantilla}",
           layout: 'pdf',
           locals: { colegiados: @colegiados,
                     parametros: @parametros,
                     documento: @documento,
                     host: @host, port: @port }
  end

  def pie_html
    ApplicationController.render(template: 'pdfs/pie',
                                 layout: false,
                                 assigns: { colegio: Colegio.first })
  end

  def registrar_documento
    return unless @documento.documento_personal
    doc = DocumentoColegiado.new(@parametros)
    doc.nombre_documento = @nombre
    doc.save
  end

  def nombre_fichero
    if @documento.documento_personal
      "#{colegiados.numero}_#{colegiados.apellidos}_#{Time.now.to_i}.pdf"
    else
      "#{@documento.codigo}_#{Time.now.to_i}.pdf"
    end
  end

end
