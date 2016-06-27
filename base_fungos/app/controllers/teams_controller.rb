class TeamsController < ApplicationController
  
  def index
    @teams = Team.all
  end
  
  
  def new
  end
  
  
  def create
    
    @team = Team.new(ask_params)
    @team.user_id    = current_user.id
    @team.status_ace = false
    
    if @team.save
      redirect_to root_url, notice: "Your request to join that project was sent, now you have to wait for the coordinator to accept you."
    else
      redirect_to prj_ask_path(:id => @team.project_id), notice: "Please fill in your name and the reasons you want to join this project!"
    end
    
  end
  
  
  def edit_c
    @team = Team.find(params[:id])
  end
  
  
  def edit_a
    @team = Team.find(params[:id])
  end
  
  
  # Remover um usuario de uma equipe
  def rem
    @team = Team.find(params[:id])
    @team.status_ace = false
    
    if @team.save
      redirect_to coord_path, notice: "User unassigned successfully!"
    else
      redirect_to :back, notice: "Couldn't unassign the user from this project. Please contact system administrator."
    end
    
  end
  
  
  # Aceitar um novo usuario na equipe
  def assign
    
    # Modifica a equipe
    @team = Team.find(params[:id])
    @team.status_ace = true
    
    # Modifica o usuario, atribuindo o novo coordenador
    @user = User.find(@team.user_id)
    @user.u_id = current_user.id
    
    if @team.save && @user.save
      redirect_to coord_path, notice: "User assigned successfully!"
    else
      redirect_to :back, notice: "Couldn't assign the user into this project. Please contact system administrator."
    end
  end
  
  
  # Aceitar novamente o usuario na equipe
  def reassign
    @team = Team.find(params[:id])
    @team.status_ace = true
    
    if @team.save
      redirect_to coord_path, notice: "User assigned successfully!"
    else
      redirect_to :back, notice: "Couldn't assign the user into this project. Please contact system administrator."
    end
  end
  
  
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to coord_path, notice: "Invitation discarded successfully."
  end
  
  
  # Métodos privados
  private
  
  def ask_params
    params.require(:team).permit(:user_id,:project_id,:team_role_id,:nome,:descricao)
  end
  
end
