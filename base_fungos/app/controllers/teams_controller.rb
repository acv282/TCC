class TeamsController < ApplicationController
	
	def index
		@teams = Team.all
	end
	
	
	def new
	end
	
	
	def create
		
		@team = Team.new(ask_params)
		@team.user_id    = current_user.id
		@team.nome       = current_user.nomeExibicao
		@team.status_ace = false
		
		if @team.save
			redirect_to root_url, notice: "Your request to join that project was sent, now you have to wait for the coordinator to accept you."
			else
			redirect_to prj_ask_path(:id => @team.project_id), notice: "Please fill in your name and the reasons you want to join this project!"
		end
		
	end
	
	
	def edit_c
		@team = Team.find(params[:id])
		
		# Em alguns casos, o usuario pode estar sem um projeto atribuido,
		# entao exibe um formulario que nao e especifico de time
		if @team.project != nil
			render 'edit_c' and return
			else
			@user = User.find(@team.user_id)
			render 'edit_u' and return
		end
		
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
		@user.status_ace = true
		if current_user.user_role_id == 3
			@user.u_id = current_user.id
		end
		
		if @team.save && @user.save
			
			# Envia email avisando o usuario sobre a aprovacao
			FungosMailer.email_usuario_aprov(@user).deliver
			
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
		@team  = Team.find(params[:id])
		@user  = User.find(@team.user_id)
		@quant = 0
		
		# Verifica se a requisicao deletada e de um usuario que só possui ela.
		# Neste caso, deleta o usuario também, para não ficar solto no sistema
		Team.all.each do |t|
			if t.user_id == @team.user_id
				@quant += 1
			end
		end
		
		# Elimina a requisicao de acesso ao projeto
		if @team.destroy
			
			# Envia email avisando o usuario sobre a rejeição
			FungosMailer.email_usuario_rej(@user).deliver
			
			# Se era o unico time / projeto do usuario, elimina o usuario
			if @quant <= 1
				if @user.user_role_id == 3
					@user.destroy
					redirect_to coord_path, notice: "Invitation discarded successfully. User deleted from system." and return
				end
			end
			redirect_to coord_path, notice: "Invitation discarded successfully." and return
		end
	end
	
	
	# Métodos privados
	private
	
	def ask_params
		params.require(:team).permit(:user_id,:project_id,:team_role_id,:nome,:descricao)
	end
	
end
