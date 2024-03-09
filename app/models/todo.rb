# frozen_string_literal: true

# Model class from generator.
class Todo < ApplicationRecord
  validates :name, presence: true
end
