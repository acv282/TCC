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
	
	
	def update
		
		@user = User.find(params[:id])
		
		if @user.update(user_params)
			
			# Envia e-mail para o coordenador dizendo que ele foi aceito
			if @user.user_role_id == 2 && @user.status_ace
				FungosMailer.email_coord_aprov(@user).deliver
			end
			
			redirect_to admin_path, notice: "Coordinator saved successfully"
			else
			redirect_to admin_path, notice: "System Failure. No modifications were made"
		end
		
	end
	
	
	def destroy
		
		@user = User.find(params[:id])
		
		if @user.destroy
			
			# Ao eliminar o usuario, elimina tambem todos os vinculos
			# dele com projetos
			Team.all.each do |t|
				if t.user_id == @user.id
					t.destroy
				end
			end
			
			# Envia email ao coordenador dizendo que foi rejeitado
			FungosMailer.email_coord_rej(@user).deliver
			
			redirect_to admin_path, notice: "User removed successfully" and return
			
			else
			redirect_to admin_path, notice: "System Failure. No modifications were made" and return
			
		end
	end
	
	
	#def coord_apr_s  
	#end
	
	
	# Cria um novo coordenador inativo, que irá aguardar aprovação de um
	# administrador
	def new_coord
		@user = User.new
	end
	
	
	# Aprovacao de novo coordenador
	def coord_approve
		@coord = User.find(params[:id])
		@projects = Project.projetos_coord(@coord.id)
	end
	
	
	def create_coord
		
		@user = User.new(user_params)
		@user.user_role_id = 2
		@user.status_ace   = false
		
		if @user.save
			# Envia o e-mail para o usuario
			FungosMailer.email_criacao_usuario(@user).deliver
			# Envia o e-mail para o Administrador
			FungosMailer.email_criacao_usuario_coord(@user).deliver
			redirect_to root_url, notice: "New user created, wait until its approved before you can log in." and return
			else
			render "new_coord"
		end
		
	end
	
	
	# Metodo que retorna todos os dados da aba Coordenador
	def coord
		
		# Apenas o coordenador pode ver o conteudo desta View
		if !current_user || current_user.user_role.id != 2
			redirect_to root_url and return
		end
		
		
		# Busca dados de projetos do coordenador
		@projects = Project.projetos_coord(current_user.id)
		
		@equipesCoord = Array.new
		@teamNovos    = Array.new 
		
		Team.all.pesquisador.each do |t|
			
			if t.user.u_id == current_user.id
				# Considera usuários não modificados como novos 
				if t.created_at == t.updated_at
					# Novos pesquisadores para que o coordenador aceite ou rejeite
					@teamNovos.push(t) 
					else
					# Mantém somente os pesquisadores sob responsabilidade do coordenador
					@equipesCoord.push(t)
				end
			end
			
		end
		
		
		
		@myTeams   = Array.new
		@newGuests = Array.new
		
		Team.all.each do |t|
			
			# Recupera as equipes do coordenador
			if t.project &&  t.project.user_id == current_user.id
				if t.created_at != t.updated_at && t.status_ace 
					@myTeams.push(t)
				end
			end
			
			# Recupera convidados que querem ver o projeto
			if t.status_ace == false && t.team_role_id == 2 && current_user.id == t.project.user_id
				@newGuests.push(t)
			end
			
		end
		
		# Vasculha os projetos do coordenador para trazer os
			# organismos (arquivos)
			#@projects.each do |p|
			#  @myFiles.push(Organism.find(p.))
		#end
		
	end
	
	
	# Metodo para todas as acoes do administrador
	def admin
		
		# Apenas o administrador pode ver o conteudo desta View
		if !current_user || current_user.user_role.id != 1
			redirect_to root_url and return
		end
		
		@coordinators = User.all.coordenadores.ativo
		@newCoords    = User.all.coordenadores.inativo 
		@projects     = Project.all
		
	end
	
	
	# Metodo para exibir o perfil do usuario
	def profile
		
		if !current_user
			redirect_to root_url and return
		end
		
		@user = current_user
		
	end
	
	
	# Atualizar o perfil do usuário
	def profile_edit
		
		@user = User.find(current_user.id)
		
		if @user.update_attributes(edit_params)
				redirect_to profile_path, notice: "Personal information updated successfully" and return
			else
			render "profile"
		end
		
	end
	
	
	# Atualizar a senha
	def password_edit
		
		@user = User.find(current_user.id)
		
		puts BCrypt::Engine.hash_secret(pass_params[:senha_ant],@user.senha_salt)
		
		if @user.senha == BCrypt::Engine.hash_secret(pass_params[:senha_ant], @user.senha_salt)
			
			@user.senha = BCrypt::Engine.hash_secret(pass_params[:senha], @user.senha_salt)
			if @user.save
				redirect_to profile_path, notice: "Password changed successfully" and return
				else
				render "profile"
			end
			
			else
			
			@user.errors.add(:senha, "Current password is incorrect")
			render "profile"
			
		end
		
	end
	
	
	# Metodos privados
	private
	
	def user_params
		params.require(:user).permit(:user_role_id, :nomeUsuario, :nomeExibicao, :email, :permissao, :senha, :senha_salt, :senha_confirmation, :status_ace, :motivo)
	end
	
	def edit_params
		params.require(:user).permit(:nomeExibicao)
	end
	
	def pass_params
		params.require(:user).permit(:senha_ant, :senha, :senha_confirmation, :senha_salt)
	end
	
end
