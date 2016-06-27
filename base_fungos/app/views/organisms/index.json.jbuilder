json.array!(@organisms) do |organism|
  json.extract! organism, :id, :project_id, :organism_status_id, :nome, :descricao, :status_ace, :stream_fasta, :stream_gbk, :stream_gff
  json.url organism_url(organism, format: :json)
end
