class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nome
      t.integer :cpf
      t.integer :agencia
      t.integer :conta
      t.integer :saldo
      t.integer :usuario

      t.timestamps
    end
  end
end
