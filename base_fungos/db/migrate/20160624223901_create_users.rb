class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_role_id
      t.string :nomeUsuario, limit: 20
      t.string :nomeExibicao, limit: 40
      t.string :senha
      t.string :senha_salt
      t.string :email, limit: 50
      t.string :permissao, limit: 1
      t.boolean :status_ace
      t.integer :u_id

      t.timestamps null: false
    end
  end
end
