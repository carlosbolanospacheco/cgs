class AddOldRegimenToMovimientoColegiados < ActiveRecord::Migration[5.0]
  def change
    add_column :movimiento_colegiados, :anterior_regimen, :string
  end
end
