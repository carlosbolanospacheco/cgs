require 'fileutils'

module Ficheros
  extend ActiveSupport::Concern

  def crear_ruta(ruta)
    FileUtils::mkdir_p ruta
  end
end
