class AddActivoToRegimenColegiados < ActiveRecord::Migration[5.0]
  def change
    add_column :regimen_colegiados, :activo, :boolean, default: true
  end
end
