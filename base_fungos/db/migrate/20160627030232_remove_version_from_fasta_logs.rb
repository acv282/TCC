class RemoveVersionFromFastaLogs < ActiveRecord::Migration
  def change
    remove_column :fasta_logs, :versao, :integer
    remove_column :gff_logs, :versao, :integer
    remove_column :gbk_logs, :versao, :integer
  end
end
