class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :agent_id
      t.integer :manager_id

      t.timestamps null: false
    end
  end
end
