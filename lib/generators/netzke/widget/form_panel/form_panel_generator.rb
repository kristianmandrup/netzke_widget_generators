require 'generators/netzke/widget/abstract_base'

module Netzke::Generators::Widget
  class FormPanelGenerator < AbstractBase
    class_option :config_tool, :type => :boolean, :default => true, :desc => 'Make a configuration tool available'
    class_option :persistent, :type => :boolean, :default => true, :desc => 'Make form persistent'    

    protected
    
    def config_tool?
      options[:config_tool]
    end

    def persistent?        
      options[:persistent]      
    end

  end
end