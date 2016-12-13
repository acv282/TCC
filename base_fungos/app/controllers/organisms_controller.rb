require 'date'

class OrganismsController < ApplicationController
	before_action :set_organism, only: [:show, :edit, :update, :destroy]
	
	attr_accessor :file
	
	def index
		redirect_to projects_path and return
	end
	
	
	def show
		@organism = Organism.find(params[:id])
		if !@organism
			return
		end
	end
	
	
	def new
		@organism        = Organism.new
		@organism_status = OrganismStatus.new
		@project         = Project.find(params[:id])
	end
	
	
	def edit
		@organism        = Organism.find(params[:id])
		#@organism_status = (@organism.organism_status_id)? OrganismStatus.find(@organism.organism_status_id) : OrganismStatus.new 
		@organism_status = OrganismStatus.find(@organism.organism_status_id)
		@project         = @organism.project
	end
	
	
	def create
		
		@organism = Organism.new(organism_params)
		@organism_status = OrganismStatus.new(organism_status_params)
		
		#if @organism.save && @organism_status.save
		if @organism.save
			@organism.organism_status_id = @organism_status.id
			@organism.save
			
			update
			#redirect_to coord_path, notice: 'Organism was successfully created.' and return
			
			else
			redirect_to new_org_path(:id => @organism.project_id), notice: 'Error while creating organism, review all fields and try again' and return
		end
				
	end
	
	
	def update
		
		if params[:file]
			
			# Recupera o arquivo enviado e os parametros
			file = params[:file]
			
			# Cria um novo objeto para manipular o arquivo
			@genFile = GenFile.new
			
			# Verifica se o arquivo é suportado, se for, já processa o conteúdo
			# e mantém os dados no objeto criado
			if !@genFile.file2stream(file)
				redirect_to edit_org_path(:id => @organism.id), notice: 'File format is not supported. Please use GenBank / .gbk files' and return
			end
			
			# Verifica se já existe um arquivo na tabela principal
				# Se existir, cria uma versao do arquivo anterior no log
			# FASTA
			if @organism.stream_fasta
				@fastalog             = FastaLog.new
				@fastalog.organism_id = @organism.id
				@fastalog.descricao   = @organism.descricao
				@fastalog.stream      = @organism.stream_fasta
				@fastalog.data        = DateTime.now
				@fastalog.save
			end
			
			# GFF
			if @organism.stream_gff
				@gfflog             = GffLog.new
				@gfflog.organism_id = @organism.id
				@gfflog.descricao   = @organism.descricao
				@gfflog.stream      = @organism.stream_gff
				@gfflog.data        = DateTime.now
				@gfflog.save
			end
			
			# GBK
			if @organism.stream_gbk
				@gbklog             = GbkLog.new
				@gbklog.organism_id = @organism.id
				@gbklog.descricao   = @organism.descricao
				@gbklog.stream      = @organism.stream_gbk
				@gbklog.data        = DateTime.now
				@gbklog.save
			end
			
			# Salva na tabela principal do organismo (versão atual)
			@organism.stream_gff   = @genFile.str_gff
			@organism.stream_gbk   = @genFile.str_gbk
			@organism.stream_fasta = @genFile.str_fasta
			
		end
		
		# Se não existir um status, cria, senão edita
			# if @organism.organism_status_id
			# @organism_status = OrganismStatus.find(@organism.organism_status_id)
			# @organism_status.update(organism_status_params)
			# else
			# @organism_status = OrganismStatus.new(organism_status_params)
			# @organism_status.save()
		# end
		
		@organism_status = OrganismStatus.find_by(organism_status_params)
		
		if @organism.update(organism_params)
			@organism.organism_status_id = @organism_status.id
			@organism.save
			redirect_to coord_path, notice: 'Organism was successfully updated.' and return
			else
			redirect_to edit_org_path(:id => @organism.id), notice: 'Error while updating organism, review all fields and try again' and return
		end
		
	end
	
	
	def destroy
		@organism.destroy
		respond_to do |format|
			format.html { redirect_to organisms_url, notice: 'Organism was successfully destroyed.' }
			format.json { head :no_content }
		end
	end
	
	
	# Download do arquivo
	def download
		
		# Recupera os parâmetros do arquivo a ser baixado
		par = params[:token]
		par = Base64.decode64(par)
		
		# Trata os valores recebidos
		pars     = par.split("|")
		p_id     = pars[0]
		p_format = pars[1]
		
		# Validação de segurança
		if p_id != params[:id]
			redirect_to projects_path, notice: 'Error in file request' and return
		end
		
		# Busca o arquivo no banco de dados
		organ = Organism.find(p_id)
		if !organ
			redirect_to projects_path, notice: 'Organism file not found' and return
		end
		
		# Verifica o formato a ser baixado
		stream64 = ""
		format   = ""
		case p_format
			when "fasta"
			stream64 = organ.stream_fasta
			format   = "fasta"
			when "gbk"
			stream64 = organ.stream_gbk
			format   = "gbk"
			when "gff"
			stream64 = organ.stream_gff
			format   = "gff3"
		end
		
		if stream64 == ""
			redirect_to projects_path, notice: 'File is corrupt, contact system administrator' and return
		end
		
		
		# Gera um arquivo temporário para o download e retorna o stream para o navegador do usuário
		arq = "#{Rails.root}/public/files/#{format}_#{organ.id}.zip"
		send_data stream64, filename: "#{format}_#{organ.id}.zip", type: 'zip', disposition: 'attachment'
		
		
	end
	
	
	private
	
    def set_organism
		@organism = Organism.find(params[:id])
	end
	
    def organism_params
		params.require(:organism).permit(:project_id, :organism_status_id, :nome, :descricao, :descricao_status,:status_ace, :stream_fasta, :stream_gbk, :stream_gff)
	end
	
	def organism_status_params
		params.require(:organism_status).permit(:descricao, :visibilidade)
	end
	
end
