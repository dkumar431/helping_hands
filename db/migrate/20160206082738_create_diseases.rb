class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.text :description
      t.references :patient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
