class TeamRolesController < ApplicationController

  # Metodos publicos
  def new
    @team_role = TeamRole.new
  end
  
  def create
    @team_role = TeamRole.new(user_params)
    
    if @team_role.save
      redirect_to root_url
    else
      render "new"
    end
    
  end
  
  
  # Metodos privados
  private
  
  def user_params
    params.require(:team_role).permit(:nivel, :descricao)
  end
  
end
