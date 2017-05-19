class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.string    :nombre
      t.integer   :multiplicador
    end
  end
end
