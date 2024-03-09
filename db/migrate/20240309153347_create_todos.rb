class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :name, null: false
      t.text :description
      t.integer :position

      t.timestamps
    end
    add_index :todos, :position
  end
end
