class User < ActiveRecord::Base
	
	# Relacoes de dependencia
	belongs_to :user_role
	
  # Filtros
  # Usuarios do coordenador (por id)
  scope :coord, -> (coord_id) { where u_id: coord_id }
	
	# Inicializacao
	after_initialize :inicializar
	
	# Valida campos obrigatorios e tamanhos minimos e maximos
	validates :user_role, presence: {message: "Current user role is invalid (contact system administrator)"}
	validates :nomeUsuario, uniqueness: {message: "This username was already used"} ,presence: {message: "Username cannot be empty"}, length: {maximum: 20, message: "Username too long (max: 20 chars)"}
	validates :nomeExibicao, presence: {message: "Display Name cannot be empty"}, length: {maximum: 40, message: "Display Name too long (max: 40 chars)"}
	validates :senha, presence: {message: "Password cannot be blank!"}, length: {minimum: 4, message: "Password is too short! Mininum 4 chars"}, confirmation: {message: "Both password fields must match, please correct and try again"}
	
	# Expressao Regular para validar o e-mail digitado
	VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates :email, presence: {message: "E-mail cannot be empty"}, length: {maximum: 50}, format: {with: VALID_EMAIL, message: "Given e-mail format is invalid"}
	
	
	#--
	#attr_accessible :email, :password, :password_confirmation
	attr_accessor :senha_confirmation
	
	before_save :antes_salvar
	
	
	# Metodo para inicializar o objeto que sera salvo
	def inicializar
	
	  # 3 (usuario) Comum  
	  self.user_role_id ||= '3' 
	  
	end
	
	
	# Metodo para autenticar o usuario no sistema
	def self.authenticate(nomeUsuario, password)
	
	  # Procura o usuario pelo nome de usuario informado
	  user = find_by_nomeUsuario(nomeUsuario)
	  
	  # Verifica se a senha digitada corresponde a senha no banco
	  if user && user.senha == BCrypt::Engine.hash_secret(password, user.senha_salt)
	    user
	  else
	    nil
	  end
	  
	end
	
	# Metodo para validar aprovação do login
	def self.validarLogin(nomeUsuario)
	
	  # Procura pelo nome do usuario
	  userLogin = find_by_nomeUsuario(nomeUsuario)
	  
	  if userLogin && userLogin.status_ace
	    true
	  else
	    nil
	  end
	
	end
	
	
	# Metodo de inicializacao do usuario
	def antes_salvar
	
	  # Chama metodo para criptografar a senha
	  encrypt_password
	  
	  # Configura alguns atributos
	  self.nomeUsuario  = nomeUsuario.downcase
	  self.status_ace ||= 'false'
	  self.permissao  ||= nil
	  
	end
	
	# Metodo para criptografar a senha antes de salvar na tabela
	def encrypt_password
	
	  if senha.present?
	    self.senha_salt = BCrypt::Engine.generate_salt
	    self.senha      = BCrypt::Engine.hash_secret(senha, senha_salt)
	  end
	
	end
	
end
