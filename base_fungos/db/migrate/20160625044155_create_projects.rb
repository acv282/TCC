class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :nome, limit: 200
      t.text :descricao
      t.date :dt_ini
      t.boolean :status_ace
      t.text :andamento, limit: 1
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
