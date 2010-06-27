require 'active_support/inflector'

module Netzke
  module Generators
    class BlpWidgetGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)   

      class_option :center,  :type => :string, :desc => 'Center configuration. class_name:model fx GridPanel:Boss'
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
            :class_name => "#{region[:class_name]}"#{model_js(region)}
            :ext_config => {
              :title => "#{title(region)}"
            }
          }}
        end
        res.join(",\n")
      end

      def title region
        return region[:model].pluralize if region[:model]      
        region[:class_name]
      end
     
      def model_js region
        return %Q{,     
            :model_name => "#{region[:model]}",} if region[:model]        
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
        class_name, model = region.split(':')
        region = {:name => name, :class_name => class_name}
        region.merge!(:model => model) if model
        region
      end  

      def widget_class_name
        name.camelize
      end
    end # class
  end
end