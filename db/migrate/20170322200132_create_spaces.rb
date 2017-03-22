class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.references :user
      t.string :name
      t.string :slug, null: false
      t.timestamps
    end

    add_index :spaces, [:user_id, :slug], unique: true
  end
end
