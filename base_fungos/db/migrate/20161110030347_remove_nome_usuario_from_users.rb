class RemoveNomeUsuarioFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :nomeUsuario, :string
  end
end
