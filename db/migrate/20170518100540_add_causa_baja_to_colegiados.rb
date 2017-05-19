class AddCausaBajaToColegiados < ActiveRecord::Migration[5.0]
  def change
    add_column :colegiados, :causa_baja_id, :integer
  end
end
