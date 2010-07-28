module Maptastic
  module Generators
    class InstallGenerator < Rails::Generators::Base #:nodoc:
      desc "Creates a Maptastic initializer and copies the required javascript files."

      def self.source_root
        File.expand_path("../../templates", __FILE__)
      end

      def copy_initializer
        template "maptastic.rb", "config/initializers/maptastic.rb"
      end

      def copy_javascripts
        copy_file "maptastic.js", "public/javascripts/maptastic.js"
      end

    end
  end
end

