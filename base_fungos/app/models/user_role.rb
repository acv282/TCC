class UserRole < ActiveRecord::Base
	
	# Relações de dependência
	has_many :users
	
end
