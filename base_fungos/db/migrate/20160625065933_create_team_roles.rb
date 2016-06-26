class CreateTeamRoles < ActiveRecord::Migration
  def change
    create_table :team_roles do |t|
      t.text :nivel, limit: 20
      t.text :descricao, limit: 255

      t.timestamps null: false
    end
  end
end
