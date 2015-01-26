class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :requester_id, null: false
      t.integer :blocked_id, null: false

      t.timestamps null: false
    end

    add_index :blocks, :requester_id
    add_index :blocks, :blocked_id
    add_index :blocks, [:requester_id, :blocked_id], unique: true
  end
end
