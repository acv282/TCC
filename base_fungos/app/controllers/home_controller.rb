class HomeController < ApplicationController
  def index
    # Carrega a pagina ja na aba Home (necessario para que a JQuery UI entenda que estamos na aba Home)
    redirect_to home_path
  end

  def home
    #render :layout => nil 
  end
end
