require 'bio'
  
class GenFile

  # GET e SET GBK
  def str_gbk
    @str_gbk
  end
  
  def str_gbk=(n_str_gbk)
    @str_gbk = n_str_gbk
  end
  
  
  # GET e SET GFF
  def str_gff
    @str_gff
  end
  
  def str_gff=(n_str_gff)
    @str_gff = n_str_gff
  end


  # GET e SET Fasta
  def str_fasta
    @str_fasta
  end
  
  def str_fasta=(n_str_fasta)
    @str_fasta = n_str_fasta
  end


  # Converte um arquivo carregado em stream
  def file2stream(f)
  
    # Carrega o arquivo em memória (Qualquer operação com o read irá removê-lo 
    # do buffer, por isso é necessário guardar)
    stream    = f.read
    signature = stream[0..20]
    
    # Verifica a extensão do arquivo
    # Arquivo GFF3
    if signature =~ /(gff)+.*(3)+(.[0-9].[0-9])?/i
            
      # Transforma a string em um objeto GFF3
      new_gff = Bio::GFF::GFF3.new(stream)
      
      # Extrai GFF
      @str_gff = new_gff.to_s
      
      # Extrai Fasta
      @str_fasta = new_gff.to_s.match(/^##(FASTA).*\z/im)
      
      # Extrai GBK
      # O GFF não possui informações para um GBK completo
      #@str_gbk .
          
    
    # Arquivo GBK
    elsif signature =~ /^(LOCUS).*$/i
    
      # Parse do GenBank File
      new_gbk = Bio::GenBank.new(stream)
      new_bio = Bio::Sequence.new(new_gbk.to_biosequence)
      @str_gbk = stream
      
      # Extrai Fasta
      @str_fasta = new_bio.output_fasta
      
      # GFF fica vazio
      
    end
    
      
  end
  
end
