class AddColegiadoIdToCargos < ActiveRecord::Migration[5.0]
  def change
    add_column :cargos, :colegiado_id, :integer
  end
end
