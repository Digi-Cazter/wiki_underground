class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :slug, null: false
      t.string :owner_type, null: false
      t.integer :owner_id
      t.timestamps
    end

    add_index :spaces, :slug, unique: true
    add_index :spaces, [:owner_type, :owner_id]
  end
end
