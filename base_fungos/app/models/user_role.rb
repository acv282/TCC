class UserRole < ActiveRecord::Base
	
	# Rela��es de depend�ncia
	has_many :users
	
end
