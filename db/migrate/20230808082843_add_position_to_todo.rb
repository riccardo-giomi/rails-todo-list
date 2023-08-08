# frozen_string_literal: true

class AddPositionToTodo < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :position, :integer, null: false, default: 1
    add_index :todos, :position
  end
end
