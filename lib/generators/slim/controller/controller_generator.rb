# frozen_string_literal: true

require 'rails/generators/erb/controller/controller_generator'

module Slim
  module Generators
    class ControllerGenerator < Erb::Generators::ControllerGenerator # :nodoc:
      source_root File.expand_path('templates', __dir__)

      protected

      def handler
        :slim
      end
    end
  end
end
