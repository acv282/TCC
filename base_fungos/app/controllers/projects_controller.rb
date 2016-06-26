class ProjectsController < ApplicationController

  require 'date'

  # index show new edit create update destroy
  def index
    @projects = Project.all
    
    # Se houver um usuário logado, verifica os projetos que ele já faz parte
    if current_user
    
      @teams = Array.new
      Team.all.each do |t|
        if t.user_id == current_user.id
          @teams.push(t)
        end
      end
      
    end
    
  end
  
  
  def new
    @project = Project.new
    @project.dt_ini = Date.today 
  end
  
  
  def edit
    @project = Project.find(params[:id])
  end
  
  
  def create
  
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    
    if @project.save
      redirect_to projects_path, notice: "New project created successfully."
    else
      render "new"
    end
     
  end
  
  
  def update
    @project = Project.find(params[:id])
    
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project updated successfully."
    else
      render 'edit'
    end
    
  end
  
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully removed."
  end
  
  
  # Metodo para visualizar um projeto via AJAX
  def ajax_view
  
    @project = Project.find(params[:id])
    
    respond_to do |f|
      f.js { render :layout => false }
    end
    
  end
  
  
  # Solicitações de acesso de um usuário em um projeto
  def ask
  
    # Busca o projeto escolhido pelo usuário
    @project = Project.find(params[:id])
    @team    = Team.new
    
  end
    
  
  # Metodos privados
  private
  
  def project_params
    params.require(:project).permit(:nome,:descricao,:dt_ini,:status_ace,:andamento,:user_id)
  end
  
  
end
