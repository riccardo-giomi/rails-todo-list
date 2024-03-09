# frozen_string_literal: true

(1..5).each do |n|
  Todo.create!(name: "#{n.ordinalize} thing to do", description: ('Do it! ' * n).strip, position: n)
end
