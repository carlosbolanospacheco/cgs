class AddCamposDeCenso < ActiveRecord::Migration[5.0]
  def change
    add_column :colegiados, :excluido_censo, :boolean, default: false
    add_column :colegios, :antiguedad_elegible, :integer, default: 2
  end
end
