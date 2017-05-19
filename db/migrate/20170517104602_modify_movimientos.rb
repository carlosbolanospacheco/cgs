class ModifyMovimientos < ActiveRecord::Migration[5.0]
  def change
    change_table :movimiento_colegiados do |t|
      t.remove :regimen_colegiado, :anterior_regimen
    end
    add_column :movimiento_colegiados, :tipo_movimiento_id, :integer
    add_column :movimiento_colegiados, :regimen_colegiado_id, :integer
  end
end
