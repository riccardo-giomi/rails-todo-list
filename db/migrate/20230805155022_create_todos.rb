# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
