class ApplicationMailer < ActionMailer::Base
	
	default from: "fungos.tcc@gmail.com"
	layout 'mailer'
	
	def email_teste
		mail(to: 'fungos.tcc@gmail.com', subject: 'E-mail de teste')
	end
	
	
	
	# Email enviado para o usuário que solicitou acesso ao sistema para
	# informar que a solicitação foi recebida e que ele deve aguardar resposta
	def email_criacao_usuario(user)
		@user = user
		mail(to: @user.email, subject: 'New user on system')
	end
	
	
	
	# Email enviado para o administrador do sistema quando um novo coordenador
	# solicita a criação do usuário
	def email_criacao_usuario_coord(user)
		@user = user
		@admin = User.find_by permissao: "A"
		mail(to: @admin.email, subject: 'New user on system')
	end
	
	
	
	# Email enviado para o coordenador, dono do projeto, sobre uma solicitação
	# de acesso
	def email_criacao_usuario_proj(project,user)
		@user = user
		@proj = project
		mail(to: @proj.user.email, subject: 'New access request to your project')
	end
	
	
	
	# Email de aviso, a solicitação do usuario foi aprovada
	def email_usuario_aprov(user)
		@user = user
		mail(to: @user.email, subject: 'Regarding your account approval')
	end
	
	# Email de aviso, a solicitação do usuario foi rejeitada
	def email_usuario_rej(user)
		@user = user
		mail(to: @user.email, subject: 'Regarding your account approval')
	end
	
	
	
	# Email de aviso, a solicitação de novo coordenador foi aprovada pelo administrador
	def email_coord_aprov(user)
		@user = user
		mail(to: @user.email, subject: 'Regarding your coordinator request')
	end
	
	# Email de aviso, a solicitação de novo coordenador foi rejeitada pelo administrador
	def email_coord_rej(user)
		@user = user
		mail(to: @user.email, subject: 'Regarding your coordinator request')
	end
	
end
