# frozen_string_literal: true

# A reminder of something that needs to be done.
class Todo < ApplicationRecord
  validates :title, presence: true
end
