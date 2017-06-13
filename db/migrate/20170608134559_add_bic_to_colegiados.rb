class AddBicToColegiados < ActiveRecord::Migration[5.0]
  def change
    add_column :colegiados, :bic, :string
  end
end
