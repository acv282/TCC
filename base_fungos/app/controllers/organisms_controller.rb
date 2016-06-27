require 'date'

class OrganismsController < ApplicationController
  before_action :set_organism, only: [:show, :edit, :update, :destroy]

  attr_accessor :file

  def index
    @organisms = Organism.all
  end


  def show
  end


  def new
    @organism        = Organism.new
    @organism_status = OrganismStatus.new
    @project         = Project.find(params[:id])
  end


  def edit
    @organism        = Organism.find(params[:id])
    @organism_status = (@organism.organism_status_id)? OrganismStatus.find(@organism.organism_status_id) : OrganismStatus.new
    @project         = @organism.project
  end


  def create
  
    @organism = Organism.new(organism_params)
    @organism_status = OrganismStatus.new(organism_status_params)
      
    if @organism.save && @organism_status.save
      @organism.organism_status_id = @organism_status.id
      @organism.save
      redirect_to coord_path, notice: 'Organism was successfully created.'
    else
      redirect_to new_org_path(:id => @organism.project_id), notice: 'Error while creating organism, review all fields and try again'
    end
    
    
  end


  def update
  
    if params[:file]
    
      file = params[:file]
      @genFile = GenFile.new
      @genFile.file2stream(file)
      
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
      
      # Salva na tabela principal
      @organism.stream_gff   = @genFile.str_gff
      @organism.stream_gbk   = @genFile.str_gbk
      @organism.stream_fasta = @genFile.str_fasta
      
    end
  
    # Se não existir um status, cria, senão edita
    if @organism.organism_status_id
      @organism_status = OrganismStatus.find(@organism.organism_status_id)
      @organism_status.update(organism_status_params)
    else
      @organism_status = OrganismStatus.new(organism_status_params)
      @organism_status.save()
    end
  
    if @organism.update(organism_params)
      @organism.organism_status_id = @organism_status.id
      @organism.save
      redirect_to coord_path, notice: 'Organism was successfully updated.'
    else
      redirect_to new_org_path(:id => @organism.project_id), notice: 'Error while updating organism, review all fields and try again'
    end
    
  end


  def destroy
    @organism.destroy
    respond_to do |format|
      format.html { redirect_to organisms_url, notice: 'Organism was successfully destroyed.' }
      format.json { head :no_content }
    end
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
