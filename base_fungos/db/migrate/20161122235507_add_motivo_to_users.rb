class AddMotivoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :motivo, :string
  end
end
