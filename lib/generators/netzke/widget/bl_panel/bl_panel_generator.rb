require 'generators/netzke/widget/abstract_base'
require 'generators/netzke/widget/bl_panel/template_helper'

module Netzke::Generators::Widget
  class BlPanelGenerator < AbstractBase
    class_option :center,  :type => :string, :desc => 'Center configuration. class_name:model fx GridPanel:Boss'
    class_option :south,  :type => :string, :desc => 'South configuration'
    class_option :north,  :type => :string, :desc => 'North configuration '
    class_option :east,   :type => :string, :desc => 'East configuration'
    class_option :west,   :type => :string, :desc => 'West configuration'            

    protected  

    include TemplateHelper
  
    def widget_type
      'border_layout_panel'
    end


  end # class
end