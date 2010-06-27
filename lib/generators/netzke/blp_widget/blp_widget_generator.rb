require 'active_support/inflector'

module Netzke
  module Generators
    class BlpWidgetGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)   

      class_option :center,  :type => :string, :desc => 'Center configuration. widget_class:data_class fx GridPanel:Boss'
      class_option :south,  :type => :string, :desc => 'South configuration'
      class_option :north,  :type => :string, :desc => 'North configuration '
      class_option :east,   :type => :string, :desc => 'East configuration'
      class_option :west,   :type => :string, :desc => 'West configuration'            

      def create_lib_netzke
        inside 'lib' do      
          FileUtils.mkdir('netzke') if !File.directory?('netzke')
        end
      end     
  
      def create_widget
        template 'blp_widget.erb', "lib/netzke/blp/#{name}_widget.rb"
      end   
  
      protected

      def regions_js
        res = []
        all_regions.each do |region|
          res << %Q{
          :#{region[:name]} => {
            :widget_class_name => "#{region[:widget_class]}"#{data_class_js(region)}
            :ext_config => {
              :title => "#{title(region)}"
            }
          }}
        end
        res.join(",\n")
      end

      def title region
        return region[:data_class].pluralize if region[:data_class]      
        region[:widget_class]
      end
     
      def data_class_js region
        return %Q{,     
            :data_class_name => "#{region[:data_class]}",} if region[:data_class]        
        ""
      end

      def all_regions      
        regions = []
        [:center, :north, :south, :east, :west].each do |region|
          regions << get_region(options[region], region) if options[region]
        end                
        regions
      end

      def get_region region, name
        widget_class, data_class = region.split(':')
        region = {:name => name, :widget_class => widget_class}
        region.merge!(:data_class => data_class) if data_class
        region
      end  

      def class_name
        name.camelize
      end
    end # class
  end
end