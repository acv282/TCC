class Organism < ActiveRecord::Base

  # Relações de dependência
  belongs_to :project
  belongs_to :organism_status
  
  # Validações
  validates :nome, presence: {message: "Organism's name cannot be blank"}
  validates :descricao, presence: {message: "Organism's description cannot be blank"}

end
