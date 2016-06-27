class CreateOrganismStatuses < ActiveRecord::Migration
  def change
    create_table :organism_statuses do |t|
      t.text :descricao, limit: 255
      t.text :visibilidade, limit: 1

      t.timestamps null: false
    end
  end
end
