class ChangeDataTypeForStatus < ActiveRecord::Migration
  def change
    change_column :patients, :status,  :string
  end
end
