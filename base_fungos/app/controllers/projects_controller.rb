class ProjectsController < ApplicationController
	
	require 'date'
	
	# index show new edit create update destroy
	
	def index
		@projects = Array.new
		
		# Se houver um usuário logado, verifica os projetos que ele já faz parte
		if current_user
			
			@teams = Array.new
			Team.all.each do |t|
				if t.user_id == current_user.id
					@teams.push(t)
				end
			end
			
		end
		
		# Alguns projetos podem nao estar visiveis, de acordo com as 
		# condicoes abaixo
		Project.all.each do |p|
			
			# Se o projeto esta como publico, deve aparecer (exceto se for recem criado / iniciado)
			if p.status_ace && ( p.andamento == 'C' || p.andamento == 'E' )
				@projects.push(p)
				
				# Se o usuario é coordenador do projeto, o projeto deve aparecer para ele sempre
				elsif current_user && current_user.id == p.user_id
				@projects.push(p)
				
				# O administrador tambem pode ver todos os projetos sempre
				elsif current_user && current_user.user_role_id == 1
				@projects.push(p)
				
				# Se o usuario é pesquisador e o status do projeto é em
					# andamento ou concluído, mesmo que não esteja publico,
				# deve aparecer para ele
				elsif current_user
				
				# Busca o papel deste usuario no time, se houver
				@curr_team = Team.find_by user_id: current_user.id, project_id: p.id
				if @curr_team && @curr_team.status_ace
					@projects.push(p)
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
		@project.dt_ini = Date.today 
		
		if @project.save
			redirect_to projects_path, notice: "New project created successfully."
			else
			render "new"
		end
		
	end
	
	
	def update
		@project = Project.find(params[:id])
		
		@old_coord = @project.user_id
		@new_coord = params[:user_id]
		
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
		
		# O usuario está solicitando acesso à um projeto, existem 
			# algumas situações possíveis, conforme abaixo. E para cada 
		# situação será exibido um formulário específico:
		
		# Se é um usuário anônimo (não está logado), exibe a pagina
		# com o formulário de cadastro e solicitação de acesso
		if !current_user
			# Cria um novo usuário para o formulário
			@user = User.new
			#team.build.user
			render 'ask_anon'
			return
			
			else
			render 'ask'
		end
		
	end
	
	
	# Cria um usuario antes e atribui a um time
	def ask_create
		
		# Informacoes do projeto selecionado
		@project = Project.find(params[:id])
		# Cria o time com os parametros da tela
		@team = Team.new(team_params)
		# Cria o usuario conforme solicitado
		@user = User.new(user_params)
		@user.u_id = @project.user.id
		
		
		# Inicia a transacao, sao duas operacoes, criar o usuario e 
		# inseri-lo no time, as duas devem ocorrer
		ActiveRecord::Base.transaction do
			# Salva primeiro o usuario na base
			if @user.save
				
				# Depois de criar o usuario, complementa informacoes do time
				@team.user_id    = @user.id
				@team.nome       = @user.nomeExibicao
				@team.status_ace = false
				
				if @team.save
					
					# Envia um e-mail para o usuario e outro para o coordenador do
					# projeto
					FungosMailer.email_criacao_usuario(@user).deliver
					FungosMailer.email_criacao_usuario_proj(@project,@user).deliver
					
					# Se chegar ate aqui, nenhum erro ocorreu e o redirect abaixo
						# ira finalizar o metodo, realizando o commit, senao havera
						# um rollback abaixo
					# redirect_to projects_path, notice: "Project access request saved successfully. Wait until it is approved." and return
					render 'ask_success' and return
				end
				
			end
			
			# Se nao foi possivel chegar ate o redirect acima, algo deu errado
			# entao reverte as alteracoes para evitar inconsistencias
			raise ActiveRecord::Rollback
			
		end
		
		# Exibe novamente o formulario porem destacando os campos que tiveram erro
		render 'ask_anon'
		
	end
	
	
	# Metodos privados
	private
	
	def project_params
		params.require(:project).permit(:nome,:descricao,:dt_ini,:status_ace,:andamento,:user_id)
	end
	
	def team_params
		params.require(:team).permit(:user_id,:project_id,:team_role_id,:descricao)
	end
	
	def user_params
		params.require(:user).permit(:nomeExibicao,:senha,:senha_salt,:email)
	end
	
end
