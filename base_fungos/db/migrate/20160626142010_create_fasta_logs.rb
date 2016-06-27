class CreateFastaLogs < ActiveRecord::Migration
  def change
    create_table :fasta_logs do |t|
      t.integer :organism_id
      t.integer :versao
      t.text :descricao, limit: 255
      t.binary :stream
      t.datetime :data

      t.timestamps null: false
    end
    add_index :fasta_logs, :organism_id
  end
end
