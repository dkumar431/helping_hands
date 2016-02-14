class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :char, :status
  end
end
