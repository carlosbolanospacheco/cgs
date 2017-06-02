class AddCausaBajaIdToCargoColegiados < ActiveRecord::Migration[5.0]
  def change
    add_column :cargo_colegiados, :causa_baja_id, :integer
    remove_column :colegiados, :causa_baja_id, :integer
  end
end
