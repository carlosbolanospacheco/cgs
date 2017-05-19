require 'colegiado'

describe Colegiado do
  before do
    @colegiado = Colegiado.new(numero: 123,
                               nombre: 'Carlos',
                               apellidos: 'Bolaños',
                               nif: '46775107F',
                               email: 'carlos.bolanos.pacheco@gmail.com')
  end

  it 'Valida la creación de un colegiado' do
    expect(colegiado.done?).to be_truthy
  end
end
