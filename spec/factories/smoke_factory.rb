# frozen_string_literal: true

class Smoke
  attr_accessor :field
end

FactoryBot.define do
  factory :smoke do
    field { 'field!' }
  end
end
