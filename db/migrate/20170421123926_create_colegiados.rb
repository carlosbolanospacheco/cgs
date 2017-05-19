# Crea tablas relacionadas con colegiados
class CreateColegiados < ActiveRecord::Migration[5.0]
  def change
    create_table :colegiados do |t|
      t.integer     :numero
      t.string      :nombre
      t.string      :apellidos
      t.string      :nif
      t.date        :nacimiento
      t.string      :genero
      t.attachment  :fotografia
      t.string      :email
      t.string      :telefono_fijo
      t.string      :telefono_movil
      t.string      :fax
      t.string      :cuenta_bancaria
      t.date        :alta_colegio
      t.date        :baja_colegio
      t.integer     :regimen_colegiado_id
      t.integer     :jura
      t.integer     :epp
      t.string      :nombre_empresa
      t.string      :nif_empresa
      t.text        :observaciones

      t.timestamps
    end

    add_index :colegiados, :numero
    add_index :colegiados, :apellidos
    add_index :colegiados, :nif

    create_table :regimen_colegiados do |t|
      t.string :literal
    end

    create_table :direccion_colegiados do |t|
      t.integer   :colegiado_id
      t.boolean   :principal, default: false
      t.string    :descripcion
      t.string    :direccion
      t.string    :codigo_postal
      t.string    :poblacion
      t.integer   :provincia_id
    end

    add_index :direccion_colegiados, :colegiado_id

    create_table :provincias do |t|
      t.string    :codigo
      t.string    :nombre
    end

    create_table :tipo_movimientos do |t|
      t.string    :literal
      t.string    :codigo
    end

    create_table :movimiento_colegiados do |t|
      t.integer   :colegiado_id
      t.string    :regimen_colegiado
      t.text      :observaciones

      t.timestamps
    end

    create_table :cargos do |t|
      t.string    :codigo
      t.string    :nombre
    end

    create_table :cargo_colegiados do |t|
      t.integer   :cargo_id
      t.integer   :colegiado_id
      t.date      :alta
      t.date      :baja
    end
  end
end
