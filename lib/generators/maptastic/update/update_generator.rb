module Maptastic
  module Generators
    class UpdateGenerator < Rails::Generators::Base
      desc "Updates the required javascript files."

      def self.source_root
        File.expand_path("../../templates", __FILE__)
      end
      
      def copy_javascripts
        remove_file "public/javascripts/maptastic.js"
        copy_file "maptastic.js", "public/javascripts/maptastic.js"    
      end

    end
  end
end

