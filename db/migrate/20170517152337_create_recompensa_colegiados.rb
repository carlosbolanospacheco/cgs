class CreateRecompensaColegiados < ActiveRecord::Migration[5.0]
  def change
    create_table :recompensa_colegiados do |t|
      t.integer     :colegiado_id
      t.date        :fecha
      t.text        :recompensa

      t.timestamps
    end
  end
end
