class ChangeColumnDefaultvalue < ActiveRecord::Migration
  def change
    change_column :users, :status, :string, :null => false, :default => 'A'
  end
end
