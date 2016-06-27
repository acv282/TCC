class Project < ActiveRecord::Base

  # Relações de dependência
  belongs_to :user
  has_many   :organisms

  # Filtros
  # Projetos do coordenador (por id)
  scope :projetos_coord, -> (coord_id) { where user_id: coord_id }
  
  # Validações
  validates :nome, presence: {message: "Project's name cannot be blank"}
  validates :descricao, presence: {message: "Project's description cannot be blank"}

end
