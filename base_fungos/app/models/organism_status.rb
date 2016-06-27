class OrganismStatus < ActiveRecord::Base

  # Relações de dependência
  has_one :organism

end
