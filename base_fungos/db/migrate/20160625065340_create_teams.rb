class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :team_role_id
      t.text :nome, limit: 40
      t.text :descricao, limit: 255
      t.boolean :status_ace

      t.timestamps null: false
    end
  end
end
