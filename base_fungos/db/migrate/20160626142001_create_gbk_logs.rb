class CreateGbkLogs < ActiveRecord::Migration
  def change
    create_table :gbk_logs do |t|
      t.integer :organism_id
      t.integer :versao
      t.text :descricao, limit: 255
      t.binary :stream
      t.datetime :data

      t.timestamps null: false
    end
    add_index :gbk_logs, :organism_id
  end
end
