class CreateExtratos < ActiveRecord::Migration[6.0]
  def change
    create_table :extratos do |t|
      t.string :historico
      t.integer :id_user

      t.timestamps
    end
  end
end
