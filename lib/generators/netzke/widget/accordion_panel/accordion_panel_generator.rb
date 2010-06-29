require 'generators/netzke/widget/abstract_base'

module Netzke::Generators::Widget
  class AccordionPanelGenerator < AbstractBase
    class_option :layout, :type => :string, :default => 'fit', :desc => 'How to layout the panel'

    protected
    
    def layout
      options[:layout]
    end
  end
end