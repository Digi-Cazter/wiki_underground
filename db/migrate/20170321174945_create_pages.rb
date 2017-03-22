class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.references :space
      t.string :title
      t.string :slug, null: false
      t.text :content
      t.timestamps
    end

    add_index :pages, [:space_id, :slug], unique: true
  end
end
