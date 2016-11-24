# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_roles = UserRole.create( [{nivel: 'Administrator', descricao: 'System administrator'},{nivel: 'Coordinator', descricao: 'Project coordinator'},{nivel: 'Common', descricao: 'Common system user'}] )

User.create( [{ user_role_id: '1', nomeExibicao: 'Administrator', email: 'admin@ufpr.br', senha: 'senha', senha_confirmation: 'senha', permissao: 'A', status_ace: 'true' }] )

TeamRole.create( [{nivel: 'Researcher', descricao: 'Responsible for researches inside a project. Researchers are able to view private genoma files from projects they belong to.'},{nivel: 'Guest', descricao: 'Guests can be accepted to a project and view files that are available to guests in that project.'}] )
