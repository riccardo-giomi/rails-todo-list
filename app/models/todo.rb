# frozen_string_literal: true

# Model class from generator.
class Todo < ApplicationRecord
  validates :name, presence: true

  # From the 'positioned' gem
  positioned
end
