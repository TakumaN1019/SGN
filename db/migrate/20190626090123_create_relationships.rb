class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :uhoer_id
      t.integer :uhoing_id

      t.timestamps null: false
    end

    add_index :relationships, :uhoer_id
    add_index :relationships, :uhoing_id
    add_index :relationships, [:uhoer_id, :uhoing_id], unique: true
  end
end
