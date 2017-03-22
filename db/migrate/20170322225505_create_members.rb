class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :organization
      t.references :user
      t.string :role, null: false
      t.timestamps
    end

    add_index :members, [:organization_id, :user_id], unique: true
  end
end
