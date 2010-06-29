module Netzke::Generators::Widget
  class BlPanelGenerator < AbstractBase
    module TemplateHelper
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
    end  
  end
end