class CreateOrganisms < ActiveRecord::Migration
  def change
    create_table :organisms do |t|
      t.integer :project_id
      t.integer :organism_status_id
      t.text :nome, limit: 50
      t.text :descricao, limit: 255
      t.boolean :status_ace
      t.binary :stream_fasta
      t.binary :stream_gbk
      t.binary :stream_gff

      t.timestamps null: false
    end
    add_index :organisms, :project_id
  end
end
