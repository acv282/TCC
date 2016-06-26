class Team < ActiveRecord::Base

  # Relações de dependência
  belongs_to :user
  belongs_to :project
  belongs_to :team_role

  # Filtros
  # Equipes do coordenador (por id)
  scope :coord, -> (coord_id) { where user_id: coord_id }
  # Apenas usuarios que estão na equipe como pesquisadores
  scope :pesquisador, -> { where team_role_id: '1' }
  
  # Validações
  validates :nome, presence: {message: "You must inform your name"}
	validates :descricao, presence: {message: "Please, write a brief description showing the reasons you want to join this project as a Researcher or a Guest"}
	
end
