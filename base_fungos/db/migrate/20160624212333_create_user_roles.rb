class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.text :nivel, limit: 45
      t.text :descricao, limit: 45

      t.timestamps null: false
    end
  end
end
