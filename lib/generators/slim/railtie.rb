# frozen_string_literal: true

module Slim
  module Rails
    # Extra railtie on top of the one from the slim-rails gem, to override
    # Railtie methods when using generators.
    class Railtie < ::Rails::Railtie
      generators do
        require 'generators/slim/railtie/generated_attribute'
      end
    end
  end
end
