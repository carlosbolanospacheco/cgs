class AddDateToDocumentoColegios < ActiveRecord::Migration[5.0]
  def change
    add_column :documento_colegios, :mes, :integer
    add_column :documento_colegios, :anyo, :integer
  end
end
