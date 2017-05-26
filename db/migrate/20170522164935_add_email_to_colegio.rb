class AddEmailToColegio < ActiveRecord::Migration[5.0]
  def change
    add_column :colegios, :email, :string
  end
end
