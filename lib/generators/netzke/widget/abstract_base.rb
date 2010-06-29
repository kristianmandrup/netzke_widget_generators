require 'active_support/inflector'
require 'generators/netzke/widget/namespace'

module Netzke  
  module Generators
    module Widget
      module AbstractBase < Rails::Generators::NamedBase   
        source_root File.expand_path('../../templates/widget', __FILE__)     

        def main
          create_netzke_widget_folder
          create_widget
        end
        
        protected    

        # generator actions
        # -----------------
        def create_netzke_widget_folder
          FileUtils.mkdir_p(widget_target_location) if !File.directory?(widget_target_location)
        end

        def create_widget 
          template "#{widget_template}.erb", File.join(widget_target_location, widget_type, file_name)
        end

        # helper methods
        # -----------------
        
        # override this method in your generator to customize the name of the template. 
        # by default, the naming convention is that template name matches widget_type
        def widget_template_name
          nil
        end

        def widget_template
          widget_template_name || widget_type          
        end
        
        def widget_class_name
          name.camelize
        end        

        def widget_type
          raise "You must define a protected method widget_type that return the basic type of widget generated"
        end
      
        def file_name
          name + '.rb'
        end

        def widget_target_location
          'lib/netzke/widget/'
        end
      end
    end
  end
end
