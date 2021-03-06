require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'
require_relative '../phase9/flash'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      path = "views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
      template_file = File.read(path)
      render_content(ERB.new(template_file).result(binding), "text/html")
    end

    def flash
      @flash ||= Flash.new(@req)
    end
  end
end
