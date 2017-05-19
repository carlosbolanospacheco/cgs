class DeleteTextosFromCargos < ActiveRecord::Migration[5.0]
  def change
    change_table :cargos do |t|
      t.remove :tratamiento, :nombre_completo, :nif
    end
  end
end
