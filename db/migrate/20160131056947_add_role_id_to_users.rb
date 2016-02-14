class AddRoleIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true, foreign_key: true
  end
end
#20160131054747

#20160131055917