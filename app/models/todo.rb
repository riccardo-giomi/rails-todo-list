# frozen_string_literal: true

# A reminder of something that needs to be done.
class Todo < ApplicationRecord
  acts_as_list

  validates :title, presence: true
end
