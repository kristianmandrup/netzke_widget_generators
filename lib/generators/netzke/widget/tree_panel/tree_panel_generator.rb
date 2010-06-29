require 'generators/netzke/widget/abstract_base'

module Netzke::Generators::Widget
  class TreePanelGenerator < AbstractBase
    class_option :root_node, :type => :string, :default => 'Root', :desc => 'Name of the root node'

    protected

    def root_node
      options[:root_node]
    end
  end
end