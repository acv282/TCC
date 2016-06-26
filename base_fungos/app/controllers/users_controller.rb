class UsersController < ApplicationController

  # Metodos publicos

  # Cria um novo usuario comum, ativo por padrão
  def new
  	@user = User.new
  end


  # Metodo para salvar usuario na base
  def create
  
    @user = User.new(user_params)
    @user.user_role_id = 3
    @user.status_ace   = true
    
    if @user.save
        redirect_to root_url, notice: "New user created successfully. You can log in now."
    else
      render "new"
    end
     
  end
  
  
  # Cria um novo coordenador inativo, que irá aguardar aprovação de um
  # administrador
  def new_coord
    @user = User.new
  end
  
  
  def create_coord
  
    @user = User.new(user_params)
    @user.user_role_id = 2
    @user.status_ace   = false
    
    if @user.save
      redirect_to root_url, notice: "New user created, wait until its approval before you can log in."
    else
      render "new_coord"
    end
     
  end
  
  
  def coord
  
    # Apenas o coordenador pode ver o conteudo desta View
    if !current_user || current_user.user_role.id != 2
      redirect_to root_url
    end
    
    # Busca dados de projetos do coordenador
    @projects = Project.projetos_coord(current_user.id)
    
    @equipesCoord = Array.new
    @teamNovos    = Array.new 
    
    Team.all.pesquisador.each do |t|
      
      if t.user.u_id == current_user.id
        # Mantém somente os pesquisadores sob responsabilidade do coordenador
        @equipesCoord.push(t)
      else
        # Considera apenas usuarios sem um coordenador como "novos" 
        if t.user.u_id == nil
          # Novos pesquisadores para que o coordenador aceite ou rejeite
          @teamNovos.push(t) 
        end
      end
      
    end
    
    
    @myTeams   = Array.new
    @newGuests = Array.new
    
    Team.all.each do |t|
    
      # Recupera as equipes do coordenador
      if t.project.user_id == current_user.id
        @myTeams.push(t)
      end
      
      # Recupera convidados que querem ver o projeto
      if t.status_ace == false && t.team_role_id == 2
        @newGuests.push(t)
      end
      
    end
   
  end
  
  
  # Metodos privados
  private
  
  def user_params
    params.require(:user).permit(:user_role_id, :nomeUsuario, :nomeExibicao, :email, :permissao, :senha, :senha_salt, :senha_confirmation, :status_ace)
  end

end
