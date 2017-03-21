class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.references :user
      t.string :title, null: false
      t.string :slug
      t.text :content
      t.timestamps
    end
  end
end
