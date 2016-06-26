class SessionsController < ApplicationController

  def new
  end

  
  # Ao chamar o metodo create, tenta autenticar o usuario
  def create
    
    # Verifica se o usuario pode entrar no sistema
    if User.validarLogin(params[:nomeUsuario])
      
      # Utiliza o metodo autenticar do Usuario
      user = User.authenticate(params[:nomeUsuario], params[:senha])
      
      if user
      
        # Sucesso: usuario sera redirecionado para a home de novo
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Welcome! #{user.nomeExibicao}"
        
      else
      
        # Erro: nova tentativa
        redirect_to root_url, :notice => "Invalid username or password combination, please try again..."
        
      end
    
    else
    
      redirect_to root_url, :notice => "User account is suspended or not yet approved"
    
    end
    
  end
  
  
  # Elimina a sessao
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Successfully signed out!"
  end
  
end
