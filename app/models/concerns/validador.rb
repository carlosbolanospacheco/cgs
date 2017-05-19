module Validador
  extend ActiveSupport::Concern

  def validar_nif(nif)
    letras = %w[T R W A G M Y F P D X B N J Z S Q V H L C K E]
    letra_calculada = letras[nif[0...-1].to_i % 23]
    return true if letra_calculada.eql?(nif[-1])
    errors.add(:nif, 'El formato de NIF es incorrecto, compruebe la letra indicada')
    false
  end
end
