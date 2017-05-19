require 'render_anywhere'

class DocumentoPdf
  include RenderAnywhere

  def initialize(colegiados, parametros)
    @colegiados = colegiados
    @parametros = parametros
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4', orientation: 'Landscape')
    kit.to_file("#{Rails.root}/public/system/documentos/listados/listado_colegiados_#{Time.now.to_i}.pdf")
  end

  def filename
    "listado_colegiados_#{Time.now.to_i}.pdf"
  end

  private

  attr_reader :colegiados, :parametros

  def as_html
    render template: 'documentos/listado_colegiados',
           layout: 'pdf',
           locals: { colegiados: colegiados, parametros: parametros }
  end
end
