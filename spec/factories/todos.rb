# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    title { 'I have something To Do' }
    description { 'This would be a description of what I have To Do.' }
  end
end
