# encoding: utf-8

require 'haml'

module Nanoc::Haml

  class Filter < Nanoc::Filter

    identifier :haml

    def run(content, params={})
      # Get options
      options = params.merge(:filename => filename)

      # Create context
      context = ::Nanoc::Context.new(assigns)

      # Get result
      proc = assigns[:content] ? lambda { assigns[:content] } : nil
      ::Haml::Engine.new(content, options).render(context, assigns, &proc)
    end

  end

end
