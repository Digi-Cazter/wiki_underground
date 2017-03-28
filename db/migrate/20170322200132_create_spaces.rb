class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.references :user
      t.string :name
      t.string :slug, null: false
      t.string :owner, null: false
      t.integer :owner_id
      t.timestamps
    end

    add_index :spaces, [:user_id, :slug], unique: true
    add_index :spaces, [:owner, :owner_id]
  end
end
