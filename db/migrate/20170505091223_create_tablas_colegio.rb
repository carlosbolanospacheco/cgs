class CreateTablasColegio < ActiveRecord::Migration[5.0]
  def change
    create_table :colegios do |t|
      t.string      :nombre
      t.attachment  :logo_colegio
      t.attachment  :logo_escuela
      t.attachment  :logo_formacion
      t.string      :nombre_recibos
      t.string      :direccion
      t.string      :poblacion
      t.string      :codigo_postal
      t.integer     :provincia_id
      t.string      :cif
      t.string      :telefono
      t.string      :fax
      t.string      :sufijo
      t.string      :url
    end

    create_table :bancos do |t|
      t.string    :nombre
      t.string    :codigo_pais, default: 'ES'
      t.string    :codigo_entidad
      t.string    :clave_entidad
      t.string    :codigo_localidad
    end

    create_table :paises do |t|
      t.string    :nombre
      t.string    :codigo
    end

    create_table :accounts do |t|
      t.integer   :banco_id
      t.string    :oficina
      t.string    :digitos_control
      t.string    :cuenta
      t.string    :iban
    end

    add_column :regimen_colegiados, :importe_colegio, :float, default: nil
    add_column :regimen_colegiados, :importe_consejo, :float, default: nil
    add_column :regimen_colegiados, :porcentaje_a_pagar, :float, default: nil
    add_column :regimen_colegiados, :period_id, :integer, default: nil

    add_column      :cargos, :nombre_completo, :string, default: nil
    add_column      :cargos, :tratamiento, :string, default: nil
    add_column      :cargos, :nif, :string, default: nil
    add_attachment  :cargos, :firma
  end
end
