require 'bio'
require 'tempfile'
require 'rubygems'
require 'base64'

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
		
		@str_fasta = ""
		
		# Carrega o arquivo em memória (Qualquer operação com o read irá removê-lo 
		# do buffer, por isso é necessário guardar temporariamente)
		stream    = f.read
		signature = stream[0..20]
		
		# Verifica a extensão do arquivo
			# Arquivo GFF3
		#if signature =~ /(gff)+.*(3)+(.[0-9].[0-9])?/i
		
		# Transforma a string em um objeto GFF3
		#new_gff = Bio::GFF::GFF3.new(stream)
		
		# Extrai GFF
		#@str_gff = new_gff.to_s
		
		# Extrai Fasta
		#@str_fasta = new_gff.to_s.match(/^##(FASTA).*\z/im)
		
		# Extrai GBK
			# O GFF não possui informações para um GBK completo
		#@str_gbk .
		
		
		# Arquivo GenBank GBK
		#elsif signature =~ /^(LOCUS).*$/i
		if signature =~ /^(LOCUS).*$/i
			
			# Parse do GenBank File
				# new_gbk = Bio::GenBank.new(stream)
			# new_bio = Bio::Sequence.new(new_gbk.to_biosequence)
			@str_gbk = stream
			
			# Transforma em FASTA ===========================================================
			# Auxiliares
			cont  = 0
			org   = ""
			dna   = ""
			org_m = ""
			ini_s = false
			
			# Percorre linha por linha do arquivo, tratando o que for
			# necessario para cada formato
			stream.each_line do |linha|
				
				# contador
				cont = cont + 1
				
				# Busca pelo organismo no arquivo
				if org_m = linha.match(/^[ ]*ORGANISM[ ]*(.*)$/)
					org = org_m.captures
					org = org.join.to_str
					
					# Monta a linha de cabeçalho do organismo do FASTA
					@str_fasta = @str_fasta + ">#{org}\n"
					
					
					# Senao, verifica onde começa a sequencia genética
					elsif org_m = linha.match(/^[ ]*ORIGIN[ ]*$/)
					
					# Marca um flag para início da sequencia
					ini_s = true
					
					
					# Depois do início da sequencia, verifica linha por linha
						# até que acabe, neste caso, marca o flag como falso e não
					# utiliza a linha
					elsif ini_s
					
					# Verifica se a linha toda é válida (contém apenas aminoácidos de DNA)
					# (Atualmente não processa RNA / Uracila, mas suporta mesmo assim)
					if org_m = linha.match(/^[ ]*[0-9]+([ actgu]*)$/i)
						
						dna = org_m.captures
						dna = dna.join.to_str
						dna = dna.delete(' ')
						dna = dna.upcase
						@str_fasta = @str_fasta + dna + "\n"
						
						# Se encontrar uma linha inválida, encerra a sequencia até que apareça
						# uma nova sequencia / organismo
						else
						ini_s = false
						
					end
					
				end
				
			end
			
			# Desmarca o flag no final do arquivo
			ini_s = false
			
			# Caminhos de arquivos
			f_nome = "#{Rails.root}/tmp/fasta.tmp"
			f_zip  = "#{Rails.root}/tmp/fasta.zip"
			
			
			# Grava o arquivo em um diretório temporário no servidor
			f_tmp = File.new(f_nome,'w')
			f_tmp.write(@str_fasta)
			f_tmp.close
			
			# Limpa o buffer para liberar memoria RAM do servidor
			@str_fasta = ""
			
			
			# Nome do arquivo que vai dentro do ZIP
			mask    = ""
			fz_nome = ""
			if mask = f.original_filename.match(/(.+)([.].+)/)
				fz_nome = mask.captures[0]
				fz_nome = fz_nome.to_str
				fz_nome = fz_nome + ".fasta"
			end
			
			# Se um arquivo ZIP existir, exclui
			if File.exist?(f_zip)
				File.delete(f_zip)
			end
			
			# Compacta o arquivo FASTA			
			#Zip.on_exists_proc = true
			Zip::File.open(f_zip, Zip::File::CREATE) do |z|
				z.add(fz_nome, f_nome)
				# z.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
			end
			
			
			# Apaga o arquivo .tmp
			if File.exist?(f_nome)
				File.delete(f_nome)
			end
			
			
			# Lê o arquivo ZIP gerado, como binário e retorna a string do FASTA
			if File.exist?(f_zip)
				
				f_bin = ""
				f_bin = File.read(f_zip)
				
				# f_b64 = Base64.encode64(f_bin)
				# f_bin = ""
				
				# Transfere o stream FASTA para o metodo que chamou
				@str_fasta = f_bin
				
				# Apaga o arquivo .zip
				# f_b64 = ""
				File.delete(f_zip)
				
			end
			
			# Fim do FASTA ==================================================================
			
			
			# Compacta o proprio GBK  =======================================================
			
			# Caminhos de arquivos
			f_nome = "#{Rails.root}/tmp/gbk.tmp"
			f_zip = "#{Rails.root}/tmp/gbk.zip"
			
			
			# Grava o arquivo em um diretório temporário no servidor
			f_tmp = File.new(f_nome,'w')
			f_tmp.write(stream)
			f_tmp.close
			
			
			# Nome do arquivo que vai dentro do ZIP
			mask    = ""
			fz_nome = ""
			if mask = f.original_filename.match(/(.+)([.].+)/)
				fz_nome = mask.captures[0]
				fz_nome = fz_nome.to_str
				fz_nome = fz_nome + ".gbk"
			end
			
			# Se um arquivo ZIP existir, exclui
			if File.exist?(f_zip)
				File.delete(f_zip)
			end
			
			# Compacta o arquivo GBK			
			#Zip.on_exists_proc = true
			Zip::File.open(f_zip, Zip::File::CREATE) do |z|
				z.add(fz_nome, f_nome)
				# z.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
			end
			
			
			# Apaga o arquivo .tmp
			if File.exist?(f_nome)
				File.delete(f_nome)
			end
			
			
			# Lê o arquivo ZIP gerado, como binário e retorna a string do GBK
			if File.exist?(f_zip)
				
				f_bin = ""
				f_bin = File.read(f_zip)
				
				# f_b64 = Base64.encode64(f_bin)
				# f_bin = ""
				
				# Transfere o stream GBK para o metodo que chamou
				@str_gbk = f_bin
				
				# Apaga o arquivo .zip
				# f_b64 = ""
				File.delete(f_zip)
				
			end
			# Fim do GBK  ===================================================================
			
			
			# GFF fica vazio
			
			# Nenhum erro, então sinaliza que deve continuar o processamento
			return true
			
			else
			
			# O arquivo não é suportado
			return false
			
		end
		
		
	end
	
end
