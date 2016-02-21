class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :content
      t.integer :modified_by

      t.timestamps null: false
    end
  end
end
