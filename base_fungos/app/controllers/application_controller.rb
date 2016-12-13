class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	# Metodo para retornar o usuario logado
	helper_method :current_user
	
	private
	
	# Metodo que busca o usuario autenticado, atraves da sessao e mantem
	# as informacoes dele visiveis nos demais controladores e views
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	
	
end